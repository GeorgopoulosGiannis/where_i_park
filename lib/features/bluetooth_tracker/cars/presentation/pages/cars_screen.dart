import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/pages/car_stepper_screen.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/presentation/pages/bonded_devices_screen.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/presentation/bloc/cars_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/presentation/widgets/cars_list.dart';

class CarsScreen extends StatelessWidget {
  const CarsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: state.isEdit ? Colors.red : null,
            title: state.isEdit
                ? null
                : const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Where did i Park?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        WidgetSpan(
                          child: Icon(Icons.car_rental),
                        ),
                      ],
                    ),
                  ),
            leading: state.isEdit
                ? IconButton(
                    onPressed: () {
                      context.read<CarsBloc>().add(SwitchEditState());
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                : null,
            actions: state.isEdit
                ? [
                    IconButton(
                      onPressed: state.selected.isEmpty
                          ? null
                          : () {
                              context
                                  .read<CarsBloc>()
                                  .add(RemoveSelectedEvent());
                            },
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                    ),
                  ]
                : null,
          ),
          body: const CarsList(),
          floatingActionButton: state.isEdit
              ? null
              : FloatingActionButton.extended(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CarStepperScreen(),
                      ),
                    );
                    context.read<CarsBloc>().add(LoadCarsEvent());
                  },
                  label: const Text('Add a new car'),
                  icon: const Icon(Icons.add),
                ),
        );
      },
    );
  }
}
