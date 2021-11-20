import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/presentation/bloc/bonded_devices_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';

class CarStep extends Step {
  CarStep(StepState stepState)
      : super(
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('Choose Car'),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'If you dont see your car listed below make sure that:'),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: const Text(
                  '1) You have connected at least once with your car',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: const Text(
                  '2) You have bluetooth enabled',
                ),
              ),
            ],
          ),
          content: const _CarStepBody(),
          state: stepState,
        );
}

class _CarStepBody extends StatelessWidget {
  const _CarStepBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BondedDevicesBloc, BondedDevicesState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is Loaded) {
          final devices = state.pairedDevices;
          return BlocBuilder<AddCarStepperBloc, AddCarStepperState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  hint: const Text('Select car'),
                  onChanged: (String? newValue) {
                    final dev = devices.firstWhere((c) => c.address == newValue);
                    context.read<AddCarStepperBloc>().add(
                          SelectedCarEvent(
                            Car(name: dev.name, address: dev.address),
                          ),
                        );
                  },
                  value: state.selectedCar?.address,
                  items: devices
                      .map(
                        (e) => DropdownMenuItem(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: e.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(text: '  '),
                                  TextSpan(
                                    text: '(${e.address})',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
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
                          value: e.address,
                        ),
                      )
                      .toList(),
                  selectedItemBuilder: (context) {
                    return devices
                        .map(
                          (e) => Text(
                            e.name,
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
        return Container();
      },
    );
  }
}
