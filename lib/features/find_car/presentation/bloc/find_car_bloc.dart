import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/domain/usecases/get_current_position.dart';
import 'package:where_i_park/core/domain/usecases/get_last_location.dart';
import 'package:where_i_park/features/find_car/domain/usecases/get_location_updates.dart';

part 'find_car_event.dart';
part 'find_car_state.dart';

@injectable
class FindCarBloc extends Bloc<FindCarEvent, FindCarState> {
  final GetCurrentPosition getCurrentLocation;
  final GetLastLocation getLastLocation;
  final GetLocationUpdates getLocationUpdates;

  StreamSubscription<Position>? subscription;

  FindCarBloc(
    this.getCurrentLocation,
    this.getLastLocation,
    this.getLocationUpdates,
  ) : super(
          const FindCarState(
            status: FindCarStatus.loading,
          ),
        ) {
    _registerEvents();
    final stream = getLocationUpdates();
    subscription = stream.listen((newPosition) {
      add(PositionChangedEvent(newPosition));
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }

  void _registerEvents() {
    on<LoadEvent>(_onLoadEvent);
    on<PositionChangedEvent>(_onPositionChangedEvent);
  }

  FutureOr<void> _onLoadEvent(
    LoadEvent event,
    Emitter<FindCarState> emit,
  ) async {
    final location = await getLastLocation();
    final currentPosition = await getCurrentLocation();
    double distance = 0.0;
    if (location != null) {
      distance = distanceInKmBetweenEarthCoordinates(
        LatLng(currentPosition.latitude, currentPosition.longitude),
        LatLng(
          location.position.latitude,
          location.position.longitude,
        ),
      );
    }
    emit(state.copyWith(
      status: FindCarStatus.loaded,
      currentPosition: currentPosition,
      location: location,
      distance: distance.toStringAsFixed(2),
    ));
  }

  FutureOr<void> _onPositionChangedEvent(
    PositionChangedEvent event,
    Emitter<FindCarState> emit,
  ) {
    if (state.location != null) {
      final latLng1 = LatLng(
        state.location!.position.latitude,
        state.location!.position.longitude,
      );
      final latLng2 = LatLng(
        event.position.latitude,
        event.position.longitude,
      );

      final distance = getDistance(latLng1, latLng2);
      emit(
        state.copyWith(
          currentPosition: event.position,
          distance: distance,
        ),
      );
    }
  }

  String getDistance(LatLng latLng1, LatLng latLng2) {
    final distanceInKM = distanceInKmBetweenEarthCoordinates(latLng1, latLng2);
    final distanceAsString = distanceInKM < 1
        ? '${fromKMtoMeters(distanceInKM).toStringAsFixed(2)}m'
        :'${distanceInKM.toStringAsFixed(2)}Km';

    return distanceAsString;
  }

  double fromKMtoMeters(double km) => km * 1000;

  double degreesToRadians(degrees) {
    return degrees * pi / 180;
  }

  /// reference [http://www.movable-type.co.uk/scripts/latlong.html]
  double distanceInKmBetweenEarthCoordinates(
    LatLng latLng1,
    LatLng latLng2,
  ) {
    // latLng1 = LatLng(37.89685292741937, 23.746822073613867);
    // latLng2 = LatLng(37.929784566020054, 23.7444813253017);
    double earthRadiusKm = 6371;

    final dLat = degreesToRadians(latLng2.latitude - latLng1.latitude);
    final dLon = degreesToRadians(latLng2.longitude - latLng1.longitude);

    final newLat1 = degreesToRadians(latLng1.latitude);
    final newLat2 = degreesToRadians(latLng2.latitude);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(newLat1) * cos(newLat2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }
}
