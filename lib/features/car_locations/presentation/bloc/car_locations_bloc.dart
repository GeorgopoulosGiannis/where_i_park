import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';

import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/cars/domain/usecases/get_positions_for_car.dart';
import 'package:where_i_park/features/car_locations/domain/usecases/clear_all_locations.dart';

part 'car_locations_event.dart';
part 'car_locations_state.dart';

@injectable
class CarLocationsBloc extends Bloc<CarLocationsEvent, CarLocationsState> {
  final Car? car;
  final ClearAllLocations clearAllLocations;
  final GetPositionsForCar getPositionsForCar;
  CarLocationsBloc(
    this.clearAllLocations,
    this.getPositionsForCar, {
    @factoryParam this.car,
  })  : assert(car != null),
        super(Loading()) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadCarLocations>(_onLoadCarLocations);
    on<ViewAsMap>(_onViewAsMap);
    on<ViewAsList>(_onViewAsList);
    on<ClearAll>(_onClearAll);
  }

  FutureOr<void> _onLoadCarLocations(
    LoadCarLocations event,
    Emitter<CarLocationsState> emit,
  ) async {
    emit(Loading());
    final locationsOrFailure = await getPositionsForCar(car!);
    emit(
      locationsOrFailure.fold((left) => Error(left.message), (right) {
        return Loaded(
          car: car!,
          locations: UnmodifiableListView(
            right,
          ),
        );
      }),
    );
  }

  FutureOr<void> _onClearAll(
    ClearAll event,
    Emitter<CarLocationsState> emit,
  ) async {
    emit(Loading());
    await clearAllLocations(car!);
    emit(
      Loaded(
        car: car!,
        locations: const [],
      ),
    );
  }

  FutureOr<void> _onViewAsMap(
    ViewAsMap event,
    Emitter<CarLocationsState> emit,
  ) {
    final curState = state as Loaded;
    emit(
      Loaded(
        car: curState.car,
        locations: curState.locations,
        viewStyle: ViewStyle.map,
      ),
    );
  }

  FutureOr<void> _onViewAsList(
    ViewAsList event,
    Emitter<CarLocationsState> emit,
  ) {
    final curState = state as Loaded;
    emit(
      Loaded(
        car: curState.car,
        locations: curState.locations,
        viewStyle: ViewStyle.list,
      ),
    );
  }
}
