part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent {}

class LoadCarsEvent extends CarsEvent {}

class LoadConnectedDevice extends CarsEvent {}

class AddCarsEvent extends CarsEvent {
  final List<Car> cars;

  AddCarsEvent(this.cars);
}
