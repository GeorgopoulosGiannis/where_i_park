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
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final dev = devices[index];
              bool tracking = false;
              for (var d in state.alreadyAddedDevices) {
                if (d.address == dev.address) {
                  tracking = true;
                }
              }
              final isConnected = state.connectedDeviceAddress == dev.address;
              return GestureDetector(
                onTap: tracking
                    ? null
                    : () {
                        context
                            .read<AddDeviceBloc>()
                            .add(TrackDeviceEvent(dev));
                      },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: tracking
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          dev.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            //color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      Flexible(
                        child:  Text(
                          isConnected ? 'Connected' : 'Not Connected',
                          style: const TextStyle(
                            fontSize: 17
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
