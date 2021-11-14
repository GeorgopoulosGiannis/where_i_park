import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/features/cars/data/models/car_model.dart';

import '../../../../core/failures/storage_failure.dart';

import '../../domain/repositories/car_repository.dart';
import '../../domain/entities/car.dart';

import '../../../../core/failures/failure.dart';

@LazySingleton(as: CarRepository)
class CarRepositoryImpl extends CarRepository {
  final SharedPreferences _prefs;

  CarRepositoryImpl(this._prefs);
  @override
  Future<Either<Failure, List<Car>>> getCars() async {
    try {
      final encoded = _prefs.getString(Constants.savedCarsKey);
      final listOfCars = _getListOfCars(encoded);
      return Right(listOfCars);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveCars(List<Car> cars) async {
    try {
      final encoded = _prefs.getString(Constants.savedCarsKey);
      List<CarModel> oldCars = _getListOfCars(encoded);
      final carModels = cars
          .map(
            (e) => CarModel(
              address: e.address,
              name: e.name,
            ),
          )
          .toList();
      final newCars = _mergeListsDistinct<CarModel>(oldCars, carModels);
      await _prefs.setString(Constants.savedCarsKey, json.encode(newCars));
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, List<Car>>> removeCars(List<Car> cars) async {
    try {
      final encoded = _prefs.getString(Constants.savedCarsKey);
      List<Car> savedCars = _getListOfCars(encoded);
      savedCars.removeWhere((oldCar) {
        for (var carToRemove in cars) {
          if (oldCar.address == carToRemove.address) {
            return true;
          }
        }
        return false;
      });

      await _prefs.setString(Constants.savedCarsKey, json.encode(savedCars));
      return  Right(savedCars);
    } catch (e) {
      return Left(
        StorageFailure(),
      );
    }
  }

  @override
  Car? findInSaved(String address) {
    final encoded = _prefs.getString(Constants.savedCarsKey);
    List<Car> savedCars = _getListOfCars(encoded);
    for (var car in savedCars) {
      if (car.address == address) {
        return car;
      }
    }
  }

  List<CarModel> _getListOfCars(String? encoded) {
    if (encoded == null) {
      return [];
    }
    return List<CarModel>.from(
      (json.decode(encoded) as Iterable).map(
        (m) => CarModel.fromJson(m),
      ),
    );
  }

  List<T> _mergeListsDistinct<T>(List<T> list1, List<T> list2) {
    return <T>{...list1, ...list2}.toList();
  }
}
