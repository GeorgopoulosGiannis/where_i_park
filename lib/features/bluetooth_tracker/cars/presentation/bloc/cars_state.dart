part of 'cars_bloc.dart';

enum Status { empty, loading, loaded, error }

@immutable
class CarsState extends Equatable {
  final Status status;
  final List<Car> cars;
  final String message;
  final bool isEdit;
  final List<Car> selected;

  const CarsState({
    required this.status,
    required this.cars,
    this.selected = const [],
    this.message = '',
    this.isEdit = false,
  });
  const CarsState.empty()
      : status = Status.empty,
        cars = const [],
        isEdit = false,
        selected = const [],
        message = '';

  CarsState copyWith({
    List<Car>? cars,
    String? connectedAddress,
    String? message,
    Status? status,
    bool? isEdit,
    List<Car>? selected,
  }) =>
      CarsState(
        status: status ?? this.status,
        message: message ?? this.message,
        cars: cars ?? this.cars,
        isEdit: isEdit ?? this.isEdit,
        selected: selected ?? this.selected,
      );

  @override
  List<Object?> get props => [
        status,
        message,
        cars,
        selected,
        isEdit,
      ];
}
