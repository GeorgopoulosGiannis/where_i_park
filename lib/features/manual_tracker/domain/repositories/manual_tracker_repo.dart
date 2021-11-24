import 'package:either_dart/either.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:where_i_park/core/failures/failure.dart';

abstract class ManualTrackerRepository {
  Future<Either<Failure, void>> saveCurrentLocation();

  Future<Either<Failure, Position>> getLastSaved();
}
