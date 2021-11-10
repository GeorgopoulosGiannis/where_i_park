import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:where_i_park/services/bluetooth_manager.dart';

@lazySingleton
class GetConnectedDeviceAddress {
  final SharedPreferences _prefs;

  GetConnectedDeviceAddress(this._prefs);

  String call() {
    return _prefs.getString(connectedDevice) ?? '';
  }
}
