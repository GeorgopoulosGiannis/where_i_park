import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/domain/usecases/get_current_position.dart';
import 'package:where_i_park/core/domain/usecases/get_last_location.dart';

part 'find_car_event.dart';
part 'find_car_state.dart';

@injectable
class FindCarBloc extends Bloc<FindCarEvent, FindCarState> {
  final GetCurrentPosition getCurrentLocation;
  final GetLastLocation getLastLocation;

  FindCarBloc(
    this.getCurrentLocation,
    this.getLastLocation,
  ) : super(
          const FindCarState(
            status: FindCarStatus.loading,
          ),
        ) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadEvent>(_onLoadEvent);
  }

  FutureOr<void> _onLoadEvent(
    LoadEvent event,
    Emitter<FindCarState> emit,
  ) async {
    final location = await getLastLocation();
    final currentPosition = await getCurrentLocation();
    emit(
      state.copyWith(
        status: FindCarStatus.loaded,
        currentPosition: currentPosition,
        location: location,
      ),
    );
  }
}
