import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bluetooth_device.g.dart';

@JsonSerializable()
class BluetoothDevice extends Equatable {
  final String name;
  final String address;
  final bool isConnected;

  const BluetoothDevice({
    required this.name,
    required this.address,
    required this.isConnected,
  });
  @override
  List<Object?> get props => [
        name,
        address,
        isConnected,
      ];
  Map<String, dynamic> toJson() => _$BluetoothDeviceToJson(this);

  factory BluetoothDevice.fromJson(Map<String, dynamic> json) =>
      _$BluetoothDeviceFromJson(json);
}
