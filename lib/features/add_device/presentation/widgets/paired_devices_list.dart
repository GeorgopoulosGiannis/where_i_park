import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_device_bloc.dart';

class PairedDeviceList extends StatelessWidget {
  const PairedDeviceList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDeviceBloc, AddDeviceState>(
      builder: (context, state) {
        final devices = state.devices;
        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final theme = Theme.of(context);
            final dev = devices[index];
            bool tracking = false;
            for (var d in state.alreadyAddedDevices) {
              if (d.address == dev.address) {
                tracking = true;
              }
            }
            final isConnected = state.connectedDeviceAddress == dev.address;
            return Card(
              child: ListTile(
                tileColor: tracking ? Colors.grey : theme.colorScheme.secondary,
                leading: tracking
                    ? const Icon(
                        Icons.remove_red_eye,
                      )
                    : null,
                title: Text(
                  dev.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                subtitle: Text(
                  dev.address,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                trailing: isConnected
                    ? const Icon(
                        Icons.bluetooth_connected_sharp,
                        color: Colors.green,
                      )
                    : null,
                onTap: tracking
                    ? null
                    : () {
                        context
                            .read<AddDeviceBloc>()
                            .add(TrackDeviceEvent(dev));
                      },
              ),
            );
          },
        );
      },
    );
  }
}
