part of 'manual_tracker_cubit.dart';

class ManualTrackerState extends Equatable {
  final CameraPosition? initialPosition;
  final Position? lastPosition;
  const ManualTrackerState({
    this.initialPosition,
    this.lastPosition,
  });

  @override
  List<Object> get props => [
        initialPosition ?? 0,
        lastPosition ?? 0,
      ];

  ManualTrackerState copyWith({
    CameraPosition? initialPosition,
    Position? lastPosition,
  }) =>
      ManualTrackerState(
        initialPosition: initialPosition ?? this.initialPosition,
        lastPosition: lastPosition ?? this.lastPosition,
      );
}
