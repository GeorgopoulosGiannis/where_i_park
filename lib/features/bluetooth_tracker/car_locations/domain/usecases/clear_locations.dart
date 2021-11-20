import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';

import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';

@lazySingleton
class ClearLocations extends UseCase<List<CarLocation>, ClearLocationsParams> {
  final CarLocationsRepository repo;

  ClearLocations(this.repo);
  @override
  Future<Either<Failure, List<CarLocation>>> call(
    ClearLocationsParams params,
  ) async {
    return repo.clearCarLocations(params.car, params.locations);
  }
}

class ClearLocationsParams {
  final List<CarLocation> locations;
  final Car car;

  ClearLocationsParams(this.locations, this.car);
}
