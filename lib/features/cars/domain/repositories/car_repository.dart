import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';

abstract class CarRepository {
  Future<Either<Failure, List<Car>>> getCars();

  Future<Either<Failure, void>> saveCars(List<Car> cars);

  Car? findInSaved(String address);

  Future<void> appendToCarLocations(Car savedCar, Position curLocation);

  Future<Either<Failure, void>> removeCars(List<Car> cars);

  Future<Either<Failure, void>> clearLocationForCar(Car car);
}
