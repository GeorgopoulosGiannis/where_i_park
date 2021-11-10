import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/cars/domain/repositories/car_repository.dart';

@lazySingleton
class ClearAllLocations extends UseCase<void, Car> {
  final CarRepository repo;

  ClearAllLocations(this.repo);
  @override
  Future<Either<Failure, void>> call(Car params) async {
    return repo.clearLocationForCar(params);
  }
}
