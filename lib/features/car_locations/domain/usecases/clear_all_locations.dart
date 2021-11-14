import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/cars/domain/repositories/car_locations_repository.dart';import 'package:where_i_park/features/cars/domain/repositories/car_repository.dart';

@lazySingleton
class ClearAllLocations extends UseCase<void, Car> {
  final CarLocationsRepository repo;

  ClearAllLocations(this.repo);
  @override
  Future<Either<Failure, void>> call(Car params) async {
    return repo.clearCarLocations(params);
  }
}
