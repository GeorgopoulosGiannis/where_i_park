part of 'add_car_stepper_bloc.dart';

abstract class AddCarStepperEvent extends Equatable {
  const AddCarStepperEvent();
}

class SelectedCarEvent extends AddCarStepperEvent {
  final Car car;

  const SelectedCarEvent(this.car);
  @override
  List<Object> get props => [car];
}

class SelectedMethodEvent extends AddCarStepperEvent {
  final TrackMethod method;

  const SelectedMethodEvent(this.method);

  @override
  List<Object> get props => [method];
}

class PreviousStepEvent extends AddCarStepperEvent {
  @override
  List<Object?> get props => [];
}

class NextStepEvent extends AddCarStepperEvent {
  @override
  List<Object?> get props => [];
}

class SaveCarEvent extends AddCarStepperEvent {
  @override
  List<Object?> get props => [];
}
