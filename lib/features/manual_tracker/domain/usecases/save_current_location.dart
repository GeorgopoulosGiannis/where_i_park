import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:where_i_park/features/manual_tracker/domain/repositories/manual_tracker_repo.dart';

@lazySingleton
class SaveCurrentLocation extends UseCase<void, NoParams> {
  final ManualTrackerRepository repo;

  SaveCurrentLocation(this.repo);
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repo.saveCurrentLocation();
  }
}
