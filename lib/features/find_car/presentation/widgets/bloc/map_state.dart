part of 'map_bloc.dart';

class MapState extends Equatable {
  final LatLngBounds? bounds;
  final CarLocation? lastCarLocation;
  final Position? currentPosition;

  const MapState({
    this.bounds,
    this.lastCarLocation,
    this.currentPosition,
  });

  MapState copyWith({
    LatLngBounds? bounds,
    CarLocation? lastCarLocation,
    Position? currentPosition,
  }) =>
      MapState(
          bounds: bounds ?? this.bounds,
          lastCarLocation: lastCarLocation ?? this.lastCarLocation,
          currentPosition: currentPosition ?? this.currentPosition);

  @override
  List<Object?> get props => [
        bounds,
        currentPosition,
        lastCarLocation,
      ];
}
