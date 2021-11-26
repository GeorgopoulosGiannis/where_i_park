part of 'find_car_bloc.dart';

enum FindCarStatus { loading, loaded, error }

class FindCarState extends Equatable {
  final FindCarStatus status;
  final Position? currentPosition;
  final CarLocation? location;
  final String distance;
  final String message;

  const FindCarState({
    required this.status,
    this.location,
    this.currentPosition,
    this.message = '',
    this.distance = '0.0',
  });

  FindCarState copyWith({
    FindCarStatus? status,
    Position? currentPosition,
    CarLocation? location,
    String? message,
    String? distance,
  }) =>
      FindCarState(
        status: status ?? this.status,
        currentPosition: currentPosition ?? this.currentPosition,
        location: location ?? this.location,
        message: message ?? this.message,
        distance: distance ?? this.distance,
      );

  @override
  List<Object?> get props => [
        status,
        location,
        currentPosition,
        message,
      ];


}
