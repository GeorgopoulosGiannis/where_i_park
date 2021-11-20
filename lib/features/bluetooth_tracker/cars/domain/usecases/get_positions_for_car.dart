import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/bluetooth_tracker/car_locations/domain/entities/car_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart';

@lazySingleton
class GetPositionsForCar extends UseCase<List<CarLocation>, Car> {
  final CarLocationsRepository repo;

  GetPositionsForCar(this.repo);
  @override
  Future<Either<Failure, List<CarLocation>>> call(Car params) async {
    return await repo.getCarLocations(params);
  }
}
