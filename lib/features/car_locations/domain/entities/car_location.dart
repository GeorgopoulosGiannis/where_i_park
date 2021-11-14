import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CarLocation {
  final Position position;
  final Placemark placemark;

  CarLocation({
    required this.position,
    required this.placemark,
  });
}
