import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/presentation/widgets/dialogs.dart';
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
    return StepState.indexed;
  }

  StepState getMethodStepState(AddCarStepperState state) {
    if (state.trackMethod != null) {
      return StepState.complete;
    }

    return StepState.indexed;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<AddCarStepperBloc>(
        create: (context) => sl<AddCarStepperBloc>(),
        child: BlocConsumer<AddCarStepperBloc, AddCarStepperState>(
          listener: (context, state) async {
            if (state.status == AddCarStepperStatus.error) {
              showDialog(
                context: context,
                builder: (context) {
                  return ErrorDialog(
                    body: state.errorMessage,
                    title: 'Failed to save car',
                  );
                },
              );
            }
            if (state.status == AddCarStepperStatus.saved) {
              await showDialog(
                context: context,
                builder: (context) {
                  return const SuccessDialog(
                    body: '',
                    title: 'Saved Car',
                  );
                },
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final theme = Theme.of(context);
            return Scaffold(
              appBar: AppBar(),
              body: Theme(
                data: theme.copyWith(
                  textTheme: theme.textTheme.copyWith(
                    bodyText1: theme.textTheme.bodyText1?.copyWith(
                      fontSize: 22,
                    ),
                    caption: theme.textTheme.caption?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                child: Stepper(
                  physics: const BouncingScrollPhysics(),
                  currentStep: state.currentStep,
                  onStepContinue: state.enabledCurrentStep
                      ? () {
                          final bloc = context.read<AddCarStepperBloc>();
                          state.isComplete && state.currentStep == 1
                              ? bloc.add(SaveCarEvent())
                              : bloc.add(NextStepEvent());
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
                      showSubtitle: state.currentStep == 0,
                    ),
                    MethodStep(
                      getMethodStepState(state),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
