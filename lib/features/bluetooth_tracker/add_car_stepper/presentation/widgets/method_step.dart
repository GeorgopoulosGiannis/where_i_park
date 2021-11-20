import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/presentation/widgets/dialogs.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';

class MethodStep extends Step {
  final StepState stepState;
  MethodStep(
    this.stepState,
  ) : super(
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Choose auto or manual save of location',
            ),
          ),
          subtitle: Column(
            children: const [
              Text(
                'Manual method will show notification which you will have to click in order to save location',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'Automatic method will save location automatically when device gets disconnected'),
            ],
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
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            hint: const Text('Select method'),
            onChanged: (TrackMethod? newValue) async {
              await showDialog(
                context: context,
                builder: (context) => const InfoDialog(
                  body:
                      'For automatic updates you need to allow background location permissions',
                  title: 'Location permissions',
                ),
              );
              context
                  .read<AddCarStepperBloc>()
                  .add(SelectedMethodEvent(newValue!));
            },
            value: state.trackMethod,
            items: TrackMethod.values
                .map(
                  (e) => DropdownMenuItem(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: e.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                      ),
                    ),
                    value: e,
                  ),
                )
                .toList(),
            selectedItemBuilder: (context) {
              return TrackMethod.values
                  .map(
                    (e) => Text(
                      e.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        );
      },
    );
  }
}
