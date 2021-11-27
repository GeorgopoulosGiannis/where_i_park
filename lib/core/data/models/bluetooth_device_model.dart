import 'package:json_annotation/json_annotation.dart';
import 'package:where_i_park/features/add_device/domain/entities/bluetooth_device.dart';

part 'bluetooth_device_model.g.dart';

@JsonSerializable()
class BluetoothDeviceModel extends BluetoothDevice {
  const BluetoothDeviceModel({
    required String address,
    required String name,
  }) : super(
          address: address,
          name: name,
        );

  factory BluetoothDeviceModel.fromDevice(BluetoothDevice device) => BluetoothDeviceModel(
        address: device.address,
        name: device.name,
      );

  Map<String, dynamic> toJson() => _$BluetoothDeviceModelToJson(this);

  factory BluetoothDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$BluetoothDeviceModelFromJson(json);
}
