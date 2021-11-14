import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CarLocation extends Equatable {
  final Position position;
  final Placemark placemark;

  const CarLocation({
    required this.position,
    required this.placemark,
  });

  @override
  List<Object?> get props => [
        position,
        placemark,
      ];
}
