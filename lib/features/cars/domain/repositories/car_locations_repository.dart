import 'package:either_dart/either.dart';

import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';

abstract class CarLocationsRepository {
  Future<Either<Failure, List<CarLocation>>> getCarLocations(Car car);

  Future<Either<Failure, List<CarLocation>>> pushToCarLocations(
    Car car,
    CarLocation location,
  );

  Future<Either<Failure, List<CarLocation>>> clearCarLocations(
    Car car,
    List<CarLocation> locationsToRemove,
  );
}
