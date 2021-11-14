import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:where_i_park/features/cars/domain/usecases/remove_car.dart';

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
  final RemoveCars removeCars;

  CarsBloc(
    this.getUserCars,
    this.saveCars,
    this.removeCars,
  ) : super(const CarsState.empty()) {
    _registerEvents();
    add(LoadCarsEvent());
  }

  void _registerEvents() {
    on<LoadCarsEvent>(_onLoadCarsEvent);
    on<AddCarsEvent>(_onAddCarsEvent);
    on<SwitchEditState>(_onSwitchEditState);
    on<SelectCar>(_onSelectCar);
    on<RemoveSelectedEvent>(_onRemoveSelectedEvent);
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

  FutureOr<void> _onSwitchEditState(
    SwitchEditState event,
    Emitter<CarsState> emit,
  ) {
    emit(
      state.copyWith(
        isEdit: !state.isEdit,
        selected: const [],
      ),
    );
  }

  FutureOr<void> _onSelectCar(
    SelectCar event,
    Emitter<CarsState> emit,
  ) {
    List<Car> newSelected = state.selected.contains(event.car)
        ? state.selected.where((element) => event.car != element).toList()
        : [...state.selected, event.car];

    emit(
      state.copyWith(selected: newSelected),
    );
  }

  FutureOr<void> _onRemoveSelectedEvent(
    RemoveSelectedEvent event,
    Emitter<CarsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final newCarsOrFailure = await removeCars(state.selected);
    emit(
      state.copyWith(
        status: Status.loaded,
        cars: newCarsOrFailure.fold(
          (left) => [],
          (right) => right,
        ),
        selected: [],
        isEdit: false,
      ),
    );
  }
}
