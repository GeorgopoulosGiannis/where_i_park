import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/entities/car_location.dart';
import 'package:where_i_park/core/domain/usecases/delete_location.dart';
import 'package:where_i_park/features/history/domain/usecases/get_all_locations.dart';

part 'history_event.dart';
part 'history_state.dart';

@injectable
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetAllLocations getAllLocations;
  final DeleteLocations deleteLocations;

  HistoryBloc(
    this.getAllLocations,
    this.deleteLocations,
  ) : super(const HistoryState(
          status: Status.loading,
          locations: [],
          selected: [],
        )) {
    _registerEvents();
  }

  void _registerEvents() {
    on<LoadLocationsEvent>(_onLoadLocationsEvent);
    on<EditEvent>(_onEditEvent);
    on<StopEditEvent>(_onStopEditEvent);
    on<SelectLocationEvent>(_onSelectLocationEvent);
    on<DeSelectLocationEvent>(_onDeSelectLocationEvent);
    on<DeleteSelectedEvent>(_onDeleteSelectedEvent);
  }

  FutureOr<void> _onLoadLocationsEvent(
    LoadLocationsEvent event,
    Emitter<HistoryState> emit,
  ) async {
    final locations = await getAllLocations();
    emit(
      locations.isEmpty
          ? const HistoryState(
              status: Status.empty,
              locations: [],
              selected: [],
            )
          : HistoryState(
              status: Status.loaded,
              locations: locations.reversed.toList(),
              selected: const [],
            ),
    );
  }

  FutureOr<void> _onEditEvent(
    EditEvent event,
    Emitter<HistoryState> emit,
  ) {
    emit(
      state.copyWith(
        status: Status.editing,
      ),
    );
  }

  FutureOr<void> _onStopEditEvent(
    StopEditEvent event,
    Emitter<HistoryState> emit,
  ) {
    emit(
      state.copyWith(
        status: Status.loaded,
        selected: const [],
      ),
    );
  }

  FutureOr<void> _onSelectLocationEvent(
    SelectLocationEvent event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(selected: [...state.selected, event.loc]));
  }

  FutureOr<void> _onDeSelectLocationEvent(
    DeSelectLocationEvent event,
    Emitter<HistoryState> emit,
  ) {
    final newSelected = state.selected.where((l) => l != event.loc).toList();

    emit(state.copyWith(selected: newSelected));
  }

  FutureOr<void> _onDeleteSelectedEvent(
    DeleteSelectedEvent event,
    Emitter<HistoryState> emit,
  ) async {
    await deleteLocations(state.selected);
    add(LoadLocationsEvent());
  }
}
