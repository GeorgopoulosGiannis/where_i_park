import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/failures/failure.dart';

import '../entities/car.dart';
import '../repositories/car_repository.dart';

@lazySingleton
class SaveCars extends UseCase<void, List<Car>> {
  final CarRepository repo;

  SaveCars(this.repo);
  @override
  Future<Either<Failure, void>> call(List<Car> params) async {
    return await repo.saveCars(params);
  }
}
