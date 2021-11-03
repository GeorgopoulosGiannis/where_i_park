
import 'package:either_dart/either.dart';

import '../../failures/failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {}