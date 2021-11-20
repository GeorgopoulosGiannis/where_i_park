import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/widgets/car_step.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/widgets/method_step.dart';
import 'package:where_i_park/services/injector.dart';

class CarStepperScreen extends StatelessWidget {
  const CarStepperScreen({Key? key}) : super(key: key);

  StepState getCarStepState(AddCarStepperState state) {
    if (state.selectedCar != null) {
      return StepState.complete;
    }
    if (state.currentStep == 0) {
      return StepState.editing;
    }
    return StepState.indexed;
  }

  StepState getMethodStepState(AddCarStepperState state) {
    if (state.trackMethod != null) {
      return StepState.complete;
    }
    if (state.currentStep == 1) {
      return StepState.editing;
    }
    return StepState.indexed;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<AddCarStepperBloc>(
        create: (context) => sl<AddCarStepperBloc>(),
        child: BlocBuilder<AddCarStepperBloc, AddCarStepperState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Stepper(
                physics: const BouncingScrollPhysics(),
                currentStep: state.currentStep,
                onStepContinue: state.enabledCurrentStep
                    ? () {
                        if (state.isComplete) {
                        context.read<AddCarStepperBloc>().add(SaveCarEvent());  
                        }
                        context.read<AddCarStepperBloc>().add(NextStepEvent());
                      }
                    : null,
                onStepCancel: state.currentStep > 0
                    ? () {
                        context
                            .read<AddCarStepperBloc>()
                            .add(PreviousStepEvent());
                      }
                    : null,
                steps: [
                  CarStep(
                    getCarStepState(state),
                  ),
                  MethodStep(
                    getMethodStepState(state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
