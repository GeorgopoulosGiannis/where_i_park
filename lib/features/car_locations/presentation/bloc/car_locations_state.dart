part of 'car_locations_bloc.dart';

enum ViewStyle { list, map }

abstract class CarLocationsState extends Equatable {
  const CarLocationsState();

  @override
  List<Object> get props => [];
}

class Loading extends CarLocationsState {}

class Loaded extends CarLocationsState {
  final Car car;
  final List<CarLocation> locations;
  final ViewStyle viewStyle;

  const Loaded({
    required this.car,
    required this.locations,
    this.viewStyle = ViewStyle.list,
  });

  @override
  List<Object> get props => [
        viewStyle,
        car,
        locations,
      ];
}

class Error extends CarLocationsState {
  final String message;

  const Error(this.message);
}
