import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/failures/storage_failure.dart';

import '../../domain/repositories/car_repository.dart';
import '../../domain/entities/car.dart';

import '../../../../core/failures/failure.dart';

const savedCarsKey = 'SAVED_CARS_KEY';

@LazySingleton(as: CarRepository)
class CarRepositoryImpl extends CarRepository {
  final SharedPreferences _prefs;

  CarRepositoryImpl(this._prefs);
  @override
  Future<Either<Failure, List<Car>>> getCars() async {
    try {
      final encoded = _prefs.getString(savedCarsKey);
      final listOfCars = _getListOfCars(encoded);
      return Right(listOfCars);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveCars(List<Car> cars) async {
    try {
      final encoded = _prefs.getString(savedCarsKey);
      List<Car> oldCars = _getListOfCars(encoded);
      final newCars = _mergeListsDistinct<Car>(oldCars, cars);
      await _prefs.setString(savedCarsKey, json.encode(newCars));
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, void>> removeCars(List<Car> cars) async {
    try {
      final encoded = _prefs.getString(savedCarsKey);
      List<Car> oldCars = _getListOfCars(encoded);
      oldCars.removeWhere((oldCar) {
        for (var carToRemove in cars) {
          if (oldCar.address == carToRemove.address) {
            return true;
          }
        }
        return false;
      });

      await _prefs.setString(savedCarsKey, json.encode(oldCars));
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure(),
      );
    }
  }

  @override
  Car? findInSaved(String address) {
    final encoded = _prefs.getString(savedCarsKey);
    List<Car> savedCars = _getListOfCars(encoded);
    for (var car in savedCars) {
      if (car.address == address) {
        return car;
      }
    }
  }

  @override
  Future<void> appendToCarLocations(
    Car savedCar,
    Position curLocation,
  ) async {
    final newCar = Car(
      address: savedCar.address,
      name: savedCar.name,
      isConnected: savedCar.isConnected,
      previousLocations: [...savedCar.previousLocations, curLocation],
    );
    await removeCars([savedCar]);
    await saveCars([newCar]);
  }

  List<Car> _getListOfCars(String? encoded) {
    if (encoded == null) {
      return [];
    }
    return List<Car>.from(
      (json.decode(encoded) as Iterable).map(
        (m) => Car.fromJson(m),
      ),
    );
  }

  List<T> _mergeListsDistinct<T>(List<T> list1, List<T> list2) {
    return <T>{...list1, ...list2}.toList();
  }

  @override
  Future<Either<Failure, void>> clearLocationForCar(Car car) async {
    try {
      final saved = findInSaved(car.address);
      if (saved != null) {
        final newCar = Car(
          address: saved.address,
          isConnected: saved.isConnected,
          name: saved.name,
          previousLocations:const [],
        );
        await removeCars([car]);
        await saveCars([newCar]);
        
      }
      return const Right(null);
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
