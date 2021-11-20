import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';

class CarLocationModel extends CarLocation {
  const CarLocationModel({
    required Placemark placemark,
    required Position position,
  }) : super(placemark: placemark, position: position);

  factory CarLocationModel.fromJson(Map<String, dynamic> json) {
    return CarLocationModel(
      placemark: Placemark.fromMap(json['placemark']),
      position: Position.fromMap(json['position']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placemark': placemark.toJson(),
      'position': position.toJson(),
    };
  }
}
