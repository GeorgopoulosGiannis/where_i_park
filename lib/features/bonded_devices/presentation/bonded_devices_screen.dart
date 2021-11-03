import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bonded_devices_bloc.dart';

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
                return ListView.builder(
                  itemCount: state.pairedDevices.length,
                  itemBuilder: (context, i) {
                    final item = state.pairedDevices[i];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.address),
                      tileColor: i % 2 != 0 ? Colors.grey[200] : null,
                      onTap: () {},
                    );
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
