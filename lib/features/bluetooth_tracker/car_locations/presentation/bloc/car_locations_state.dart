part of 'car_locations_bloc.dart';

enum ViewStyle { list, map }

enum CarLocationStatus { loading, loaded, error }

class CarLocationsState extends Equatable {
  final CarLocationStatus status;
  final Car car;
  final List<CarLocation> locations;
  final ViewStyle viewStyle;
  final String message;
  final bool isEdit;
  final List<CarLocation> selected;

  const CarLocationsState({
    required this.status,
    required this.car,
    required this.locations,
    this.selected = const [],
    this.message = '',
    this.isEdit = false,
    this.viewStyle = ViewStyle.map,
  });

  CarLocationsState.initial(this.car)
      : status = CarLocationStatus.loading,
        locations = [],
        selected = const [],
        isEdit = false,
        message = '',
        viewStyle = ViewStyle.map;

  @override
  List<Object> get props => [
        viewStyle,
        car,
        locations,
        selected,
        status,
        isEdit,
        message,
      ];

  CarLocationsState copyWith({
    CarLocationStatus? status,
    Car? car,
    List<CarLocation>? locations,
    ViewStyle? viewStyle,
    String? message,
    bool? isEdit,
    List<CarLocation>? selected,
  }) {
    return CarLocationsState(
      status: status ?? this.status,
      car: car ?? this.car,
      locations: locations ?? this.locations,
      viewStyle: viewStyle ?? this.viewStyle,
      isEdit: isEdit ?? this.isEdit,
      message: message ?? this.message,
      selected: selected ?? this.selected,
    );
  }
}
