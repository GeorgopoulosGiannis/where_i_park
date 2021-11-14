import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';

@lazySingleton
class GetConnectedDevice {
  final SharedPreferences _prefs;

  GetConnectedDevice(this._prefs);
  String call() {
    return _prefs.getString(Constants.connectedDevice) ?? '';
  }
}
