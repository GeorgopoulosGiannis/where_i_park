import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/presentation/widgets/bonded_devices_list.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/presentation/bloc/cars_bloc.dart'
    show AddCarsEvent, CarsBloc;

import '../bloc/bonded_devices_bloc.dart';

class BondedDevicesScreen extends StatelessWidget {
  const BondedDevicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paired Devices'),
        ),
        body: Center(
          child: BlocBuilder<BondedDevicesBloc, BondedDevicesState>(
            builder: (context, state) {
              if (state is Error) {
                return const Center(
                  child: Text('error'),
                );
              }
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is Loaded) {
                return BondedDevicesList(
                  devices: state.pairedDevices,
                  onDeviceTap: (item) {
                    context.read<CarsBloc>().add(
                          AddCarsEvent(
                            [
                              Car(
                                tracking: TrackMethod.automatic,
                                name: item.name,
                                address: item.address,
                              ),
                            ],
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                );
              }
              return Center(
                child: Text(
                  'No paired devices found,\nmake sure you have connected to your car via bluetooth at least once',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
