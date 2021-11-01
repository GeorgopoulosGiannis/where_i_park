import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:flutter/material.dart';

class BondedDevicesScreen extends StatefulWidget {
  const BondedDevicesScreen({Key? key}) : super(key: key);

  @override
  State<BondedDevicesScreen> createState() => _BondedDevicesScreenState();
}

class _BondedDevicesScreenState extends State<BondedDevicesScreen> {
  Map<String, dynamic> bondedDevices = {};
  Map<String, dynamic> monitoringCars = {};

  @override
  void initState() {
    BluetoothEvents.getBondedDevices().then((value) {
      bondedDevices = value;
      setState(() {});
    });
    super.initState();
  }

  bool _isAlreadyMonitoring(MapEntry<String, dynamic> item) {
    return monitoringCars.containsKey(item.key);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Paired Devices'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: bondedDevices.length,
            itemBuilder: (context, index) {
              final item = bondedDevices.entries.elementAt(index);
              final title = item.value['name'] != item.value['alias']
                  ? '${item.value['name']} ( ${item.value['alias']} )'
                  : item.value['name'];
              return ListTile(
                title: Text(title),
                subtitle: Text(item.key),
                trailing: _isAlreadyMonitoring(item)
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
                tileColor: index % 2 != 0 ? Colors.grey[200] : null,
                onTap: () {
                  Navigator.pop<MapEntry<String, dynamic>>(
                      context, bondedDevices.entries.elementAt(index));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
