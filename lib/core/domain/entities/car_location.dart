import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../features/add_device/domain/entities/bluetooth_device.dart';

/// CarLocation contains all the information about a saved location
class CarLocation extends Equatable {
  final Position position;
  final BluetoothDevice? device;

  const CarLocation({
    required this.position,
    this.device,
  });
  bool get isAssociatedWithDevice => device == null;

  DateTime get savedAt => position.timestamp!;

  @override
  List<Object?> get props => [
        position,
        device,
      ];
}
