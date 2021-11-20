import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/failures/failure.dart';
import '../../../../../core/domain/usecases/usecase.dart';

import '../entities/car.dart';
import '../repositories/car_repository.dart';

@lazySingleton
class GetUserCars extends UseCase<List<Car>, NoParams> {
  final CarRepository repo;

  GetUserCars(this.repo);
  @override
  Future<Either<Failure, List<Car>>> call(NoParams params) {
    return repo.getCars();
  }
}
