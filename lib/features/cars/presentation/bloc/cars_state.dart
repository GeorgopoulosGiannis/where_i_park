part of 'cars_bloc.dart';

@immutable
abstract class CarsState {}

class Empty extends CarsState {}

class Loading extends CarsState {}

class Loaded extends CarsState {
  final List<Car> cars;

  Loaded(this.cars);
}

class Error extends CarsState {
  final String message;

  Error(this.message);
}
