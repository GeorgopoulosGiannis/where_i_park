import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/services/location_manager.dart';

@lazySingleton
class GetCurrentLocation extends UseCase<Position, NoParams> {
  final LocationManager locationManager;

  GetCurrentLocation(this.locationManager);

  @override
  Future<Either<Failure, Position>> call(NoParams params) async {
    try {
      return Right(
        await locationManager.getCurrentLocation(),
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
