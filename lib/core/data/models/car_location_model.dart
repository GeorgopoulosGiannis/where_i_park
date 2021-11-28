import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/car_location.dart';
import 'bluetooth_device_model.dart';

part 'car_location_model.g.dart';

@JsonSerializable(explicitToJson:true)
class CarLocationModel extends CarLocation {
  final BluetoothDeviceModel? deviceModel;

  @PositionConverter()
  final Position positionModel;

  const CarLocationModel({
    required this.positionModel,
    this.deviceModel,
  }) : super(
          position: positionModel,
          device: deviceModel,
        );

  Map<String, dynamic> toJson() => _$CarLocationModelToJson(this);

  factory CarLocationModel.fromJson(Map<String, dynamic> json) =>
      _$CarLocationModelFromJson(json);
}

class PositionConverter extends JsonConverter<Position, Map<String, dynamic>> {
  const PositionConverter();
  @override
  Position fromJson(Map<String, dynamic> json) {
    return Position.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(Position object) {
    return object.toJson();
  }
}
