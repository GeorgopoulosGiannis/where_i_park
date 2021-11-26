import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/domain/usecases/get_current_position.dart';
import 'package:where_i_park/core/domain/usecases/get_last_location.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetCurrentPosition getCurrentPosition;
  final GetLastLocation getLastLocation;

  MapBloc(
    this.getCurrentPosition,
    this.getLastLocation,
  ) : super(const MapState()) {
    _registerEvents();
  }
  void _registerEvents() {
    on<LoadCurrentPosition>(_onLoadCurrentPosition);
    on<SetBoundsEvents>(_onSetBoundsEvents);
    on<LoadLastCarLocation>(_onLoadLastCarLocation);
  }

  FutureOr<void> _onLoadCurrentPosition(
    LoadCurrentPosition event,
    Emitter<MapState> emit,
  ) async {
    final curPosition = await getCurrentPosition();
    emit(state.copyWith(
      currentPosition: curPosition,
    ));
  }

  FutureOr<void> _onLoadLastCarLocation(
    LoadLastCarLocation event,
    Emitter<MapState> emit,
  ) async {
    final lastLoc = await getLastLocation();
    emit(
      state.copyWith(
        lastCarLocation: lastLoc,
      ),
    );
  }

  FutureOr<void> _onSetBoundsEvents(
    SetBoundsEvents event,
    Emitter<MapState> emit,
  ) {}
}
