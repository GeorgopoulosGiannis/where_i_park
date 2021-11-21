import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';

class MethodStep extends Step {
  final StepState stepState;
  const MethodStep(
    this.stepState,
  ) : super(
          title: const Padding(
            padding: EdgeInsets.only(
              bottom: 10.0,
              top: 20.0,
            ),
            child: Text(
              'Choose auto or manual save of location',
            ),
          ),
          content: const _MethodStepBody(),
          state: stepState,
        );
}

class _MethodStepBody extends StatelessWidget {
  const _MethodStepBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCarStepperBloc, AddCarStepperState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RadioListTile(
                title: Text(TrackMethod.automatic.text),
                subtitle: const Text(
                    'Save location automatically in background'),
                value: TrackMethod.automatic,
                groupValue: state.trackMethod,
                onChanged: (TrackMethod? method) {
                  context
                      .read<AddCarStepperBloc>()
                      .add(SelectedMethodEvent(method!));
                },
              ),
              RadioListTile(
                value: TrackMethod.notification,
                title: Text(TrackMethod.notification.text),
                subtitle: const Text(
                  'Shows notification which you will have to click in order to save notification',
                ),
                groupValue: state.trackMethod,
                onChanged: (TrackMethod? method) {
                  context
                      .read<AddCarStepperBloc>()
                      .add(SelectedMethodEvent(method!));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
