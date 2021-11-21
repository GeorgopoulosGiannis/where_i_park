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
  saved,
}

class AddCarStepperState extends Equatable {
  final int currentStep;
  final AddCarStepperStatus status;
  final Car? selectedCar;
  final TrackMethod trackMethod;
  final String errorMessage;

  bool get enabledCurrentStep =>
      currentStep == 0 && selectedCar != null || currentStep == 1;
  bool get isComplete => selectedCar != null && currentStep == 1;

  const AddCarStepperState({
    required this.status,
    required this.currentStep,
    required this.selectedCar,
    required this.trackMethod,
    this.errorMessage = '',
  });

  AddCarStepperState copyWith({
    Car? selectedCar,
    TrackMethod? trackMethod,
    int? currentStep,
    AddCarStepperStatus? status,
    String? errorMessage,
  }) =>
      AddCarStepperState(
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage,
          selectedCar: selectedCar ?? this.selectedCar,
          trackMethod: trackMethod ?? this.trackMethod,
          currentStep: currentStep ?? this.currentStep);

  @override
  List<Object> get props => [
        selectedCar ?? -1,
        trackMethod,
        currentStep,
        status,
        errorMessage,
      ];
}
