import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';

import '../bloc/add_device_bloc.dart';
import 'device_list_container.dart';

class DevicesList extends StatelessWidget {
  final List<BluetoothDevice> devices;
  final void Function(BluetoothDevice)? onTap;
  const DevicesList({
    Key? key,
    required this.devices,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListContainer(
      ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
        ),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final dev = devices[index];
          final isConnected =
              context.watch<AddDeviceBloc>().state.connectedDeviceAddress ==
                  dev.address;
          return GestureDetector(
            onTap: onTap != null ? () => onTap!(dev) : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      dev.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      isConnected ? 'Connected' : 'Not Connected',
                      style: const TextStyle(fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
