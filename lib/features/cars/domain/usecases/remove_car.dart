import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/cars/domain/repositories/car_repository.dart';

@lazySingleton
class RemoveCars extends UseCase<List<Car>, List<Car>> {
  final CarRepository repo;

  RemoveCars(this.repo);
  @override
  Future<Either<Failure, List<Car>>> call(List<Car> params) {
    return repo.removeCars(params);
  }
}
