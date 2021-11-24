import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/manual_tracker/domain/repositories/manual_tracker_repo.dart';

@lazySingleton
class GetLastManual extends UseCase<Position, NoParams> {
  final ManualTrackerRepository repo;

  GetLastManual(this.repo);
  @override
  Future<Either<Failure, Position>> call(NoParams params) {
    return repo.getLastSaved();
  }
}
