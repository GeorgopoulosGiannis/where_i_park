part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadMarkersForCar extends MapEvent {
  final Car car;
  final List<CarLocation> locations;

  const LoadMarkersForCar(
    this.car,
    this.locations,
  );
}

class MarkerTappedEvent extends MapEvent {
  final MarkerId markerId;

  const MarkerTappedEvent(this.markerId);
}
