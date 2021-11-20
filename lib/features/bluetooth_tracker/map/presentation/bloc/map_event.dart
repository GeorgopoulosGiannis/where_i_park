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

class SelectLocationEvt extends MapEvent{
  final CarLocation location;

  const SelectLocationEvt(this.location);
}

class MarkerTappedEvent extends MapEvent {
  final CarLocation loc;

  const MarkerTappedEvent(this.loc);
}
