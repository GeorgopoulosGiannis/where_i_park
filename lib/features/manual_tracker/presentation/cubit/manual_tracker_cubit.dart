import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/domain/usecases/get_current_location.dart';
import 'package:where_i_park/features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart';

part 'manual_tracker_state.dart';

@injectable
class ManualTrackerCubit extends Cubit<ManualTrackerState> {
  final GetCurrentLocation getCurrentLocation;

  ManualTrackerCubit(
    this.getCurrentLocation,
  ) : super(
          const ManualTrackerState(),
        );

  void saveCurrent() {}

  void load() async {
    final currentOrFailure = await getCurrentLocation(NoParams());
    emit(
      currentOrFailure.fold(
        (left) => state.copyWith(
          initialPosition: MapBloc.defPosition,
        ),
        (right) => state.copyWith(
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
