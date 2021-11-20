part of 'add_car_stepper_bloc.dart';

enum TrackMethod { automatic, notification }

extension Name on TrackMethod {
  String get text {
    switch (this) {
      case TrackMethod.automatic:
        return 'Automatic';
      case TrackMethod.notification:
        return 'Manual';
    }
  }
}

enum AddCarStepperStatus {
  loading,
  loaded,
  error,
}

class AddCarStepperState extends Equatable {
  final int currentStep;
  final AddCarStepperStatus status;
  final Car? selectedCar;
  final TrackMethod? trackMethod;

  bool get enabledCurrentStep =>
      currentStep == 0 && selectedCar != null ||
      currentStep == 1 && trackMethod != null;
  bool get isComplete => selectedCar != null && trackMethod != null;
  
  const AddCarStepperState({
    required this.status,
    required this.currentStep,
    required this.selectedCar,
    required this.trackMethod,
  });

  AddCarStepperState copyWith({
    Car? selectedCar,
    TrackMethod? trackMethod,
    int? currentStep,
    AddCarStepperStatus? status,
  }) =>
      AddCarStepperState(
          status: status ?? this.status,
          selectedCar: selectedCar ?? this.selectedCar,
          trackMethod: trackMethod ?? this.trackMethod,
          currentStep: currentStep ?? this.currentStep);

  @override
  List<Object> get props => [
        selectedCar ?? -1,
        trackMethod ?? -1,
        currentStep,
        status,
      ];
}
