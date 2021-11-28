import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/add_device/presentation/widgets/list_title.dart';
import 'package:where_i_park/features/home/presentation/widgets/home_item_icon_container.dart';

import '../../../../services/injector.dart';

import '../../domain/entities/bluetooth_device.dart';
import '../widgets/devices_list.dart';

import '../bloc/add_device_bloc.dart';

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      return ColoredBox(
                        color: theme.colorScheme.surface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ListTitle(
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
                            const ListTitle(
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
                        ),
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
                        color: theme.colorScheme.onPrimary,
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
