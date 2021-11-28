import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/home/presentation/widgets/home_item_icon_container.dart';

import '../../../../services/injector.dart';

import '../../domain/entities/bluetooth_device.dart';
import '../widgets/devices_list.dart';

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
          body: FutureBuilder<void>(
              future: Future.delayed(
                const Duration(seconds: 1),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return BlocBuilder<AddDeviceBloc, AddDeviceState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _ListTitle(
                            text: 'All devices',
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state.devicesNotTracked.isNotEmpty
                                  ? DevicesList(
                                      devices: state.devicesNotTracked,
                                      onTap: (BluetoothDevice dev) =>
                                          context.read<AddDeviceBloc>().add(
                                                TrackDeviceEvent(
                                                  dev,
                                                ),
                                              ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'No devices, make sure bluetooth is open',
                                      ),
                                    ),
                            ),
                          ),
                          const _ListTitle(
                            text: 'Tracking devices',
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: state.alreadyAddedDevices.isNotEmpty
                                  ? DevicesList(
                                      devices: state.alreadyAddedDevices,
                                      onTap: (BluetoothDevice dev) =>
                                          context.read<AddDeviceBloc>().add(
                                                RemoveTrackDeviceEvent(dev),
                                              ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'No devices added yet',
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Center(
                  child: Hero(
                    tag: 'bluetooth_icon',
                    child: HomeItemIconContainer(
                      child: Icon(
                        Icons.bluetooth_drive,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 65,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class _ListTitle extends StatelessWidget {
  final String text;
  const _ListTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
