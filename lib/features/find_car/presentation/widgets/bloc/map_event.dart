part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentPosition extends MapEvent {
  const LoadCurrentPosition();
}

class LoadLastCarLocation extends MapEvent {
  const LoadLastCarLocation();
}

class SetBoundsEvents extends MapEvent {
  const SetBoundsEvents();
}
