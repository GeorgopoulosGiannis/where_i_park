import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/data/car_location_model.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/core/failures/failure.dart';

import 'package:either_dart/either.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';

@LazySingleton(as: CarLocationsRepository)
class CarLocationsRepositoryImpl extends CarLocationsRepository {
  final SharedPreferences _prefs;

  CarLocationsRepositoryImpl(this._prefs);

  @override
  Future<Either<Failure, List<CarLocation>>> clearCarLocations(
    Car car, {
    List<CarLocation>? locationsToRemove,
  }) async {
    try {
      final allLocations = _getLocationsFromStorage();
      final carLocations = allLocations[car.address];
      if (carLocations == null || carLocations.isEmpty) {
        return const Right(<CarLocation>[]);
      }

      carLocations.removeWhere(
          (element) => locationsToRemove?.contains(element) ?? true);

      allLocations[car.address] = carLocations;
      _prefs.setString(Constants.carLocations, json.encode(allLocations));
      return Right(carLocations);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Either<Failure, List<CarLocation>>> getCarLocations(Car car) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final locations = _getLocationsFromStorage();
      if (locations[car.address] != null) {
        return Right(locations[car.address]!);
      }
      return const Right(<CarLocation>[]);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Either<Failure, List<CarLocation>>> pushToCarLocations(
    Car car,
    CarLocation location,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();

      final locations = _getLocationsFromStorage();
      final newLoc = CarLocationModel(
        position: location.position,
        placemark: location.placemark,
      );
      if (locations[car.address] != null) {
        locations[car.address] = [
          ...locations[car.address]!,
          newLoc,
        ];
      } else {
        locations[car.address] = [newLoc];
      }
      await _prefs.setString(Constants.carLocations, json.encode(locations));
      return Right(locations[car.address]!);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  Map<String, List<CarLocationModel>> _getLocationsFromStorage() {
    Map<String, List<CarLocationModel>> result = {};
    final carLocationsString = _prefs.getString(Constants.carLocations);
    if (carLocationsString == null) {
      return result;
    }
    final Map<String, dynamic> res = json.decode(carLocationsString);
    res.forEach((key, value) {
      result[key] = (value as List<dynamic>)
          .map(
            (e) => CarLocationModel.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList();
    });
    return result;
  }
}
