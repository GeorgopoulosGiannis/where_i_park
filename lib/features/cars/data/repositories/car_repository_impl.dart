import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/failures/storage_failure.dart';

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
      final listOfCars =
          encoded != null ? json.decode(encoded) as List<Car> : <Car>[];
      return Right(listOfCars);
    } catch (e) {
      return Left(StorageFailure());
    }
  }
}
