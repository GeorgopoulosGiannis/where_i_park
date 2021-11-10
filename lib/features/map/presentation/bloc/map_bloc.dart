import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/cars/domain/entities/car.dart';
import 'package:where_i_park/features/map/domain/usecases/clear_all_locations.dart';

part 'map_event.dart';
part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final ClearAllLocations clearAllLocations;
  MapBloc(
    this.clearAllLocations,
  ) : super(MapInitial()) {
    _registerEvents();
  }
  void _registerEvents() {
    on<ClearAll>(_onClearAll);
  }

  FutureOr<void> _onClearAll(
    ClearAll event,
    Emitter<MapState> emit,
  ) async {
    await clearAllLocations(event.car);
  }
}
