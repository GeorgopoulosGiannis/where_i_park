import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_i_park/core/presentation/bloc/app_bloc.dart';
import 'package:where_i_park/features/bluetooth_tracker/bonded_devices/domain/entities/bluetooth_device.dart';

class BondedDevicesList extends StatelessWidget {
  final List<BluetoothDevice> devices;
  final void Function(BluetoothDevice)? onDeviceTap;
  const BondedDevicesList({
    Key? key,
    required this.devices,
    this.onDeviceTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, i) => const Divider(),
      itemCount: devices.length,
      itemBuilder: (context, i) {
        final item = devices[i];
        return ListTile(
          title: Text(item.name),
          subtitle: Text(item.address),
          trailing:
              item.address == context.watch<AppBloc>().state.connectedDevice
                  ? const CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                  : null,
          onTap: onDeviceTap != null ? () => onDeviceTap!(item) : null,
        );
      },
    );
  }
}
