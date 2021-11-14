part of 'cars_bloc.dart';

enum Status { empty, loading, loaded, error }

@immutable
class CarsState extends Equatable {
  final Status status;
  final List<Car> cars;
  final String message;

  const CarsState({
    required this.status,
    required this.cars,
    this.message = '',
  });
  const CarsState.empty()
      : status = Status.empty,
        cars = const [],
        message = '';

  CarsState copyWith({
    List<Car>? cars,
    String? connectedAddress,
    String? message,
    Status? status,
  }) =>
      CarsState(
        status: status ?? this.status,
        message: message ?? this.message,
        cars: cars ?? this.cars,
      );

  @override
  List<Object?> get props => [
    status,
    message,
    cars,
  ];
}
