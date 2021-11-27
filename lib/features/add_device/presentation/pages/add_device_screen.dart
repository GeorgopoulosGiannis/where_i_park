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
          body: const PairedDeviceList(),
        ),
      ),
    );
  }
}
