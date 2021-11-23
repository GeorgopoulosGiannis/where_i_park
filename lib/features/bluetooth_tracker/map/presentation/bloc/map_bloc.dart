import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/helpers/helpers.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';

import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/usecases/get_positions_for_car.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/domain/usecases/get_current_location.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;
  final GetPositionsForCar getPositionsForCar;

  MapBloc(
    this.getCurrentLocation,
    this.getPositionsForCar,
  ) : super(const MapState.initial()) {
    _registerEvents();
  }
  void _registerEvents() {
    on<LoadMarkersForCar>(_onLoadMarkersForCar);
    on<MarkerTappedEvent>(_onMarkerTappedEvent);
    on<SelectLocationEvt>(_onSelectLocationEvt);
  }

  FutureOr<void> _onLoadMarkersForCar(
    LoadMarkersForCar event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    final markers = createMarkers(
      event.car,
      event.locations,
    );
    CameraPosition cameraPosition;

    if (event.locations.isEmpty) {
      final locOrFalure = await getCurrentLocation(NoParams());
      cameraPosition = locOrFalure.fold(
        (left) => defPosition,
        (right) => CameraPosition(
          zoom: 19.151926040649414,
          target: LatLng(
            right.latitude,
            right.longitude,
          ),
        ),
      );
    } else {
      cameraPosition = getLastPosition(
        event.locations.map((e) => e.position).toList(),
      );
    }
    emit(
      state.copyWith(
        status: Status.loaded,
        car: event.car,
        markers: markers,
        cameraPosition: cameraPosition,
        zoomedLocation: event.locations.first,
      ),
    );
  }

  Future<CameraPosition> getCameraPosition(List<Position> positions) async {
    if (positions.isEmpty) {
      final locOrFalure = await getCurrentLocation(NoParams());
      return locOrFalure.fold(
        (left) => defPosition,
        (right) => CameraPosition(
          zoom: 19.151926040649414,
          target: LatLng(
            right.latitude,
            right.longitude,
          ),
        ),
      );
    } else {
      return getLastPosition(positions);
    }
  }

  @visibleForTesting
  Map<CarLocation, Marker> createMarkers(
    Car car,
    List<CarLocation> previousLocs,
  ) {
    final markers = <CarLocation, Marker>{};
    var i = 0;
    for (var loc in previousLocs) {
      final id = '${car.address}-$i';
      final markerId = MarkerId(id);
      final marker = Marker(
        markerId: markerId,
        position: LatLng(loc.position.latitude, loc.position.longitude),
        infoWindow: InfoWindow(
          title: car.name,
          snippet: loc.position.timestamp != null
              ? Helpers.toLocaleDateString(loc.position.timestamp!)
              : '-',
        ),
        onTap: () {
          add(MarkerTappedEvent(loc));
        },
      );
      markers[loc] = marker;
      i++;
    }
    return markers;
  }

  @visibleForTesting
  CameraPosition getLastPosition(List<Position> positions) {
    final lastLocation = positions.last;
    final cameraPosition = CameraPosition(
      target: LatLng(
        lastLocation.latitude,
        lastLocation.longitude,
      ),
      zoom: 19.151926040649414,
    );
    return cameraPosition;
  }

  static CameraPosition get defPosition => const CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414,
      );

  FutureOr<void> _onMarkerTappedEvent(
    MarkerTappedEvent event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(
        zoomedLocation: event.loc,
      ),
    );
  }

  FutureOr<void> _onSelectLocationEvt(
    SelectLocationEvt event,
    Emitter<MapState> emit,
  ) {
    final newMarkers = state.markers.map((key, value) {
      return MapEntry(
        key,
        value.copyWith(iconParam: BitmapDescriptor.defaultMarker),
      );
    })
      ..update(event.location, (marker) {
        return marker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
        );
      });
    emit(
      state.copyWith(
        markers: newMarkers,
        zoomedLocation:
            state.zoomedLocation == event.location ? null : event.location,
      ),
    );
  }
}
