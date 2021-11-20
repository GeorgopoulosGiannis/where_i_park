import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/usecases/clear_locations.dart';

import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/usecases/get_positions_for_car.dart';

part 'car_locations_event.dart';
part 'car_locations_state.dart';

@injectable
class CarLocationsBloc extends Bloc<CarLocationsEvent, CarLocationsState> {
  final Car? car;
  final ClearLocations clearLocations;
  final GetPositionsForCar getPositionsForCar;
  CarLocationsBloc(
    this.clearLocations,
    this.getPositionsForCar, {
    @factoryParam this.car,
  })  : assert(car != null),
        super(CarLocationsState.initial(car!)) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadCarLocations>(_onLoadCarLocations);
    on<ViewAsMap>(_onViewAsMap);
    on<ViewAsList>(_onViewAsList);
    on<ClearSelected>(_onClearSelected);
    on<SwitchCarLocationsEditState>(_onSwitchCarLocationsEditState);
    on<AddToSelected>(_onAddToSelected);
  }

  FutureOr<void> _onLoadCarLocations(
    LoadCarLocations event,
    Emitter<CarLocationsState> emit,
  ) async {
    emit(state.copyWith(status: CarLocationStatus.loading));
    final locationsOrFailure = await getPositionsForCar(car!);
    emit(
      locationsOrFailure.fold(
          (left) => state.copyWith(
                status: CarLocationStatus.error,
                message: left.message,
              ), (right) {
        return state.copyWith(
          status: CarLocationStatus.loaded,
          car: car!,
          locations: UnmodifiableListView([
            ...{...right.reversed},
          ]),
        );
      }),
    );
  }

  FutureOr<void> _onClearSelected(
    ClearSelected event,
    Emitter<CarLocationsState> emit,
  ) async {
    emit(state.copyWith(status: CarLocationStatus.loading));
    final newLocationsOrFailure = await clearLocations(
      ClearLocationsParams(state.selected, state.car),
    );
    emit(
      state.copyWith(
        status: CarLocationStatus.loaded,
        car: car!,
        isEdit: false,
        locations: newLocationsOrFailure.fold(
          (left) => state.locations,
          (right) => right,
        ),
      ),
    );
  }

  FutureOr<void> _onViewAsMap(
    ViewAsMap event,
    Emitter<CarLocationsState> emit,
  ) {
    emit(state.copyWith(
      viewStyle: ViewStyle.map,
    ));
  }

  FutureOr<void> _onViewAsList(
    ViewAsList event,
    Emitter<CarLocationsState> emit,
  ) {
    emit(state.copyWith(
      viewStyle: ViewStyle.list,
    ));
  }

  FutureOr<void> _onSwitchCarLocationsEditState(
    SwitchCarLocationsEditState event,
    Emitter<CarLocationsState> emit,
  ) {
    emit(
      state.copyWith(isEdit: !state.isEdit, selected: []),
    );
  }

  FutureOr<void> _onAddToSelected(
    AddToSelected event,
    Emitter<CarLocationsState> emit,
  ) {
    List<CarLocation> newSelected = state.selected.contains(event.location)
        ? state.selected.where((element) => event.location != element).toList()
        : [...state.selected, event.location];

    emit(
      state.copyWith(
        selected: newSelected,
      ),
    );
  }
}
