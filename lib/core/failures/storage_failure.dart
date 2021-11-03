import 'package:where_i_park/core/failures/failure.dart';

class StorageFailure extends Failure {
  StorageFailure() : super('Failed to read from Storage', 0);
}
