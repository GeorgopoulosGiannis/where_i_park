import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/features/chronology/domain/usecases/get_all_locations.dart';

part 'chronology_event.dart';
part 'chronology_state.dart';

@injectable
class ChronologyBloc extends Bloc<ChronologyEvent, ChronologyState> {
  final GetAllLocations getAllLocations;

  ChronologyBloc(
    this.getAllLocations,
  ) : super(Loading()) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadLocationsEvent>(_loadLocationsEvent);
  }

  FutureOr<void> _loadLocationsEvent(
    LoadLocationsEvent event,
    Emitter<ChronologyState> emit,
  ) async {
    final locations = await getAllLocations();
    emit(
      locations.isEmpty ? Empty() : Loaded(locations.reversed.toList()),
    );
  }
}
