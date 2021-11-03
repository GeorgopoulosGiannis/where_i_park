import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';

import '../../domain/usecases/get_user_cars.dart';
import '../../domain/entities/car.dart';

part 'cars_event.dart';
part 'cars_state.dart';

@injectable
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final GetUserCars getUserCars;

  CarsBloc(
    this.getUserCars,
  ) : super(Empty()) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadCarsEvent>(_onLoadCarsEvent);
  }

  FutureOr<void> _onLoadCarsEvent(
    LoadCarsEvent event,
    Emitter<CarsState> emit,
  ) async {
    final carsOrFailure = await getUserCars(NoParams());
    emit(
      carsOrFailure.fold(
        (failure) => Error(failure.message),
        (cars) =>cars.isEmpty ? Empty() : Loaded(cars),
      ),
    );
  }
}
