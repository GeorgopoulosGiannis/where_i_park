import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../bonded_devices/domain/usecases/get_connected_device.dart';

import '../../../../core/domain/usecases/usecase.dart';

import '../../domain/usecases/save_cars.dart';
import '../../domain/usecases/get_user_cars.dart';
import '../../domain/entities/car.dart';

part 'cars_event.dart';
part 'cars_state.dart';

@lazySingleton
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final GetUserCars getUserCars;
  final SaveCars saveCars;
  final GetConnectedDeviceAddress getConnectedDeviceAddress;

  CarsBloc(
    this.getUserCars,
    this.saveCars,
    this.getConnectedDeviceAddress,
  ) : super(const CarsState.empty()) {
    _registerEvents();
    add(LoadCarsEvent());
    add(LoadConnectedDevice());
  }

  void _registerEvents() {
    on<LoadCarsEvent>(_onLoadCarsEvent);
    on<AddCarsEvent>(_onAddCarsEvent);
    on<LoadConnectedDevice>(_onLoadConnectedDevice);
  }

  FutureOr<void> _onLoadCarsEvent(
    LoadCarsEvent event,
    Emitter<CarsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final carsOrFailure = await getUserCars(NoParams());
    carsOrFailure.fold(
      (failure) {
        emit(
          state.copyWith(
            status: Status.error,
            message: failure.message,
          ),
        );
      },
      (cars) {
        emit(
          state.copyWith(
            status: cars.isEmpty ? Status.empty : Status.loaded,
            cars: cars,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAddCarsEvent(
    AddCarsEvent event,
    Emitter<CarsState> emit,
  ) async {
    await saveCars(event.cars);
    add(LoadCarsEvent());
  }

  FutureOr<void> _onLoadConnectedDevice(
    LoadConnectedDevice event,
    Emitter<CarsState> emit,
  ) async {
    final device =getConnectedDeviceAddress();
    print(device);
    emit(
      state.copyWith(
        connectedAddress: device,
      ),
    );
  }
}
