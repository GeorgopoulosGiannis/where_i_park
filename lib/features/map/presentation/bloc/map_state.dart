part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class Loading extends MapState {}

class Loaded extends MapState {
  final Car car;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;

  const Loaded({
    required this.car,
    required this.markers,
    required this.cameraPosition,
  });
}

class Error extends MapState {
  final String message;

  const Error(this.message);
}
