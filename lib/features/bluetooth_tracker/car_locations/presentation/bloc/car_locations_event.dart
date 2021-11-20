part of 'car_locations_bloc.dart';

abstract class CarLocationsEvent extends Equatable {
  const CarLocationsEvent();

  @override
  List<Object> get props => [];
}

class LoadCarLocations extends CarLocationsEvent {
  final Car car;

  const LoadCarLocations(this.car);
  @override
  List<Object> get props => [car];
}

class SwitchCarLocationsEditState extends CarLocationsEvent {}

class AddToSelected extends CarLocationsEvent {
  final CarLocation location;

  const AddToSelected(this.location);
}

class ClearSelected extends CarLocationsEvent {
  const ClearSelected();
}

class ViewAsMap extends CarLocationsEvent {}

class ViewAsList extends CarLocationsEvent {}
