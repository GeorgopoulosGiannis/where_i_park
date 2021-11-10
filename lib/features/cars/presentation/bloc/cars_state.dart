part of 'cars_bloc.dart';

enum Status { empty, loading, loaded, error }

@immutable
class CarsState extends Equatable {
  final Status status;
  final List<Car> cars;
  final String connectedAddress;
  final String message;

  const CarsState({
    required this.status,
    required this.cars,
    required this.connectedAddress,
    this.message = '',
  });
  const CarsState.empty()
      : status = Status.empty,
        cars = const [],
        connectedAddress = '',
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
        connectedAddress: connectedAddress ?? this.connectedAddress,
      );

  @override
  List<Object?> get props => [
    status,
    message,
    cars,
    connectedAddress,
  ];
}
