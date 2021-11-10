part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class ClearAll extends MapEvent {
  final Car car;

  const ClearAll(this.car);
}
