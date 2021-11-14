import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/cars/domain/usecases/get_positions_for_car.dart';
import 'package:where_i_park/features/map/domain/usecases/get_current_location.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentLocation getCurrentLocation;
  final GetPositionsForCar getPositionsForCar;

  MapBloc(
    this.getCurrentLocation,
    this.getPositionsForCar,
  ) : super(Loading()) {
    _registerEvents();
  }
  void _registerEvents() {
    on<LoadMarkersForCar>(_onLoadMarkersForCar);
    on<MarkerTappedEvent>(_onMarkerTappedEvent);
  }

  FutureOr<void> _onLoadMarkersForCar(
    LoadMarkersForCar event,
    Emitter<MapState> emit,
  ) async {
    emit(Loading());

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
    emit(Loaded(
      car: event.car,
      markers: markers,
      cameraPosition: cameraPosition,
    ));
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
  Map<MarkerId, Marker> createMarkers(
    Car car,
    List<CarLocation> previousLocs,
  ) {
    final markers = <MarkerId, Marker>{};

    for (var loc in previousLocs) {
      var i = 0;

      final markerId = MarkerId('${car.address}-$i');
      final marker = Marker(
        markerId: markerId,
        position: LatLng(loc.position.latitude, loc.position.longitude),
        infoWindow: InfoWindow(
          title: car.name,
          snippet: loc.position.timestamp != null
              ? DateFormat('dd-MM-yyyy - kk:mm').format(loc.position.timestamp!)
              : '-',
        ),
        onTap: () {
          add(MarkerTappedEvent(markerId));
        },
      );
      markers[markerId] = marker;
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

  CameraPosition get defPosition => const CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(37.43296265331129, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414,
      );

  FutureOr<void> _onMarkerTappedEvent(
    MarkerTappedEvent event,
    Emitter<MapState> emit,
  ) {
    print(event);
  }
}
