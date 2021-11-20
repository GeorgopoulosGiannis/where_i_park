part of 'cars_bloc.dart';

@immutable
abstract class CarsEvent {}

class LoadCarsEvent extends CarsEvent {}

class AddCarsEvent extends CarsEvent {
  final List<Car> cars;

  AddCarsEvent(this.cars);
}

class RemoveSelectedEvent extends CarsEvent {}

class SwitchEditState extends CarsEvent {}

class SelectCar extends CarsEvent {
  final Car car;

  SelectCar(this.car);
}
