import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/injector.dart';
import '../widgets/paired_devices_list.dart';

import '../bloc/add_device_bloc.dart';

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddDeviceBloc>()
        ..add(
          LoadDevicesEvent(),
        )
        ..add(
          LoadTrackingDevicesEvent(),
        )
        ..add(
          StartTrackingConnectedEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  left:15.0,
                  top: 8,
                ),
                child: Text(
                  'My devices',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: PairedDeviceList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
