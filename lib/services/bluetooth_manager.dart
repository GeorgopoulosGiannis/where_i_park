
import 'package:bluetooth_events/bluetooth_events.dart';
import 'package:injectable/injectable.dart';




@singleton
class BluetoothManager {
  
  static Future<void> init() async {
    await BluetoothEvents.initialize();
    await BluetoothEvents.setBluetoothEventCallback(_bluetoothCallback);
  }

  static Future<void> _bluetoothCallback(Map<String, dynamic> evt) async {
    final action = evt['ACTION'];
    if (action == 'android.bluetooth.device.action.ACL_CONNECTED') {
   //   _handleDeviceConnected(evt['DEVICE_ADDRESS']);
    } else if (action == 'android.bluetooth.device.action.ACL_DISCONNECTED') {
    //  _handleDeviceDisconnected(evt['DEVICE_ADDRESS']);
    }
  }

  Future<Map<String,dynamic>> getPairedDevices()async{
    return await BluetoothEvents.getBondedDevices();
  }

  // static Future<void> _handleDeviceConnected(String address) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final encoded = sharedPrefs.getString(savedCarsKey);
  //   if (encoded != null) {
  //     final Map<String, dynamic> savedCars = json.decode(encoded);
  //     for (var entry in savedCars.entries) {
  //       if (entry.key == address) {
  //         final newVal = {
  //           ...entry.value as Map<String, dynamic>,
  //           'CONNECTED': true
  //         };

  //         savedCars[entry.key] = newVal;
  //         sharedPrefs.setString(savedCarsKey, json.encode(savedCars));
  //       }
  //     }
  //   }
  // }

  // static Future<void> _handleDeviceDisconnected(String address) async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final encoded = sharedPrefs.getString(savedCarsKey);
  //   if (encoded != null) {
  //     final Map<String, dynamic> savedCars = json.decode(encoded);
  //     for (var entry in savedCars.entries) {
  //       if (entry.key == address) {
  //         sl<NotificationManager>().showNotification();
  //       }
  //     }
  //   }
  // }
}
