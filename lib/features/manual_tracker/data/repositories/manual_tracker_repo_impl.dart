import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:where_i_park/core/constants.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/domain/usecases/get_current_location.dart';
import 'package:where_i_park/features/manual_tracker/domain/repositories/manual_tracker_repo.dart';

@LazySingleton(as: ManualTrackerRepository)
class ManualTrackerRepoImpl extends ManualTrackerRepository {
  final GetCurrentLocation getCurrentLocation;
  final SharedPreferences prefs;

  ManualTrackerRepoImpl(
    this.getCurrentLocation,
    this.prefs,
  );

  @override
  Future<Either<Failure, void>> saveCurrentLocation() async {
    try {
      final currentLocationOrFailure = await getCurrentLocation(NoParams());
      currentLocationOrFailure.fold(
        (left) => throw UnimplementedError(),
        (right) {
          prefs.setString(
            Constants.lastManualLocation,
            json.encode(
              right.toJson(),
            ),
          );
        },
      );
      return const Right(null);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Either<Failure, Position>> getLastSaved() async {
    try {
      final last = prefs.getString(Constants.lastManualLocation);
      if (last != null) {
        final lastPosition = Position.fromMap(json.decode(last));
        return Right(lastPosition);
      }
      throw UnimplementedError();
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
