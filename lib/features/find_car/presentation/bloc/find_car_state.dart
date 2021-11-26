part of 'find_car_bloc.dart';

enum FindCarStatus { loading, loaded, error }

class FindCarState extends Equatable {
  final FindCarStatus status;
  final Position? currentPosition;
  final CarLocation? location;
  final String message;

  const FindCarState({
    required this.status,
    this.location,
    this.currentPosition,
    this.message = '',
  });

  FindCarState copyWith({
    FindCarStatus? status,
    Position? currentPosition,
    CarLocation? location,
    String? message,
  }) =>
      FindCarState(
        status: status ?? this.status,
        currentPosition: currentPosition ?? this.currentPosition,
        location: location ?? this.location,
        message: message ?? this.message,
      );
      
  @override
  List<Object?> get props => [
        status,
        location,
        currentPosition,
        message,
      ];
}
