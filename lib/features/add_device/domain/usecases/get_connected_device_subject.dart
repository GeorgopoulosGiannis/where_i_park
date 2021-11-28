import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:where_i_park/services/bluetooth_manager.dart';

@lazySingleton
class GetConnectedDeviceSubject {
  final BluetoothManager mgr;

  GetConnectedDeviceSubject(this.mgr);
  BehaviorSubject<String> call() {
    return mgr.connectedDeviceSubject;
  }
}
