import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_repository.dart';

@lazySingleton
class RemoveCars extends UseCase<List<Car>, List<Car>> {
  final CarRepository repo;
  final CarLocationsRepository locRepo;

  RemoveCars(this.repo, this.locRepo);
  @override
  Future<Either<Failure, List<Car>>> call(List<Car> params) async {
    for (var car in params) {
      await locRepo.clearCarLocations(car);
    }
    return repo.removeCars(params);
  }
}
