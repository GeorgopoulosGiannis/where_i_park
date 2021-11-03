import 'package:either_dart/either.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';

abstract class CarRepository {
  Future<Either<Failure, List<Car>>> getCars();
}
