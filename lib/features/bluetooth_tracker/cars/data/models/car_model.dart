import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';

part 'car_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CarModel extends Car {
  const CarModel({
    required String name,
    required String address,
  }) : super(
          address: address,
          name: name,
        );

  Map<String, dynamic> toJson() => _$CarModelToJson(this);

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
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
