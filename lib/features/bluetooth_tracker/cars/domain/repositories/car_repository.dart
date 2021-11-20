import 'package:either_dart/either.dart';

import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';

abstract class CarRepository {
  Future<Either<Failure, List<Car>>> getCars();

  Future<Either<Failure, void>> saveCars(List<Car> cars);

  Car? findInSaved(String address);

  Future<Either<Failure, List<Car>>> removeCars(List<Car> cars);
}
