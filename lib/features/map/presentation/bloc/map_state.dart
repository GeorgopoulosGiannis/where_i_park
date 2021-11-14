part of 'map_bloc.dart';

enum Status { loading, loaded, error }

class MapState extends Equatable {
  final Status status;
  final String message;
  final Car? car;
  final CameraPosition? cameraPosition;
  final CarLocation? zoomedLocation;
  final Map<CarLocation, Marker> markers;

  const MapState({
    required this.status,
    required this.car,
    required this.markers,
    required this.cameraPosition,
    this.message = '',
    this.zoomedLocation,
  });

  const MapState.initial()
      : status = Status.loading,
        car = null,
        message = '',
        markers = const {},
        cameraPosition = null,
        zoomedLocation = null;
  MapState copyWith({
    Status? status,
    String? message,
    Car? car,
    CameraPosition? cameraPosition,
    CarLocation? zoomedLocation,
    Map<CarLocation, Marker>? markers,
  }) =>
      MapState(
        status: status ?? this.status,
        message: message ?? this.message,
        car: car ?? this.car,
        cameraPosition: cameraPosition ?? this.cameraPosition,
        zoomedLocation: zoomedLocation ?? this.zoomedLocation,
        markers: markers ?? this.markers,
      );
  @override
  List<Object> get props => [
        car ?? 0,
        markers,
        cameraPosition ?? 0,
        status,
        message,
        zoomedLocation ?? 0,
      ];
}
