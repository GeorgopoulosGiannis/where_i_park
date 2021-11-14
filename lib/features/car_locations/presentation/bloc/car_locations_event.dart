part of 'car_locations_bloc.dart';

abstract class CarLocationsEvent extends Equatable {
  const CarLocationsEvent();

  @override
  List<Object> get props => [];
}

class LoadCarLocations extends CarLocationsEvent {
  final Car car;

  const LoadCarLocations(this.car);
}

class ClearAll extends CarLocationsEvent {
  const ClearAll();
}

class ViewAsMap extends CarLocationsEvent {}

class ViewAsList extends CarLocationsEvent {}
