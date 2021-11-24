import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/domain/usecases/get_current_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart';
import 'package:where_i_park/features/manual_tracker/domain/usecases/get_last_manual.dart';
import 'package:where_i_park/features/manual_tracker/domain/usecases/save_current_location.dart';

part 'manual_tracker_state.dart';

@injectable
class ManualTrackerCubit extends Cubit<ManualTrackerState> {
  final GetCurrentLocation getCurrentLocation;
  final SaveCurrentLocation saveCurrentLocation;
  final GetLastManual getLastManual;

  ManualTrackerCubit(
    this.getCurrentLocation,
    this.saveCurrentLocation,
    this.getLastManual,
  ) : super(
          const ManualTrackerState(),
        );

  Future<void> saveCurrent() async {
    final saveOrFailure = await saveCurrentLocation(NoParams());
    saveOrFailure.fold(
      (left) => null,
      (right) => null,
    );
  }

  void load() async {
    final currentOrFailure = await getCurrentLocation(NoParams());
    final lastOrFailure = await getLastManual(NoParams());
    final lastPosition = lastOrFailure.fold(
      (left) => null,
      (right) => right,
    );
    emit(
      currentOrFailure.fold(
        (left) => state.copyWith(
          lastPosition: lastPosition,
          initialPosition: MapBloc.defPosition,
        ),
        (right) => state.copyWith(
          lastPosition: lastPosition,
          initialPosition: CameraPosition(
            target: LatLng(
              right.latitude,
              right.longitude,
            ),
            zoom: 19.151926040649414,
            bearing: 192.8334901395799,
          ),
        ),
      ),
    );
  }
}
