part of 'car_locations_bloc.dart';

enum ViewStyle { list, map }

enum Status { loading, loaded, error }

class CarLocationsState extends Equatable {
  final Status status;
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
    this.viewStyle = ViewStyle.list,
  });

  CarLocationsState.initial(this.car)
      : status = Status.loading,
        locations = [],
        selected = const [],
        isEdit = false,
        message = '',
        viewStyle = ViewStyle.list;

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
    Status? status,
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
