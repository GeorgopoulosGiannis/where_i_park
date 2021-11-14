import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:where_i_park/features/bonded_devices/presentation/bonded_devices_screen.dart';
import 'package:where_i_park/features/cars/presentation/bloc/cars_bloc.dart';
import 'package:where_i_park/features/cars/presentation/widgets/cars_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CarsBloc>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: state.isEdit ? Colors.red : null,
        title: state.isEdit ? null : const Text('Where did i Park?'),
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
                          context.read<CarsBloc>().add(RemoveSelectedEvent());
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BondedDevicesScreen(),
                  ),
                );
              },
              label: const Text('Add a new car'),
              icon: const Icon(Icons.add),
            ),
    );
  }
}
