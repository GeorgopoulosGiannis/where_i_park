import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:where_i_park/features/bonded_devices/domain/entities/bluetooth_device.dart';

part 'car.g.dart';

@JsonSerializable(explicitToJson: true)
class Car extends BluetoothDevice {
  @PositionConverter()
  final List<Position> previousLocations;
  const Car({
    required String name,
    required String address,
    required bool isConnected,
    required this.previousLocations,
  }) : super(
          name: name,
          address: address,
          isConnected: isConnected,
        );

  @override
  Map<String, dynamic> toJson() => _$CarToJson(this);

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
}

class PositionConverter extends JsonConverter<List<Position>, List<dynamic>> {
  const PositionConverter();
  @override
  List<Position> fromJson(List<dynamic> json) {
    
    return json.map((item) => Position.fromMap(item)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<Position> object) {
    return object.map((position) => position.toJson()).toList();
  }
}
