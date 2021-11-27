import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/core/domain/usecases/get_current_position.dart';
import 'package:where_i_park/core/domain/usecases/save_current_location.dart';
import 'package:where_i_park/core/domain/usecases/usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SaveCurrentLocation saveCurrentLocation;

  HomeBloc(
    this.saveCurrentLocation,
  ) : super(Idle()) {
    registerEvents();
  }

  void registerEvents() {
    on<SaveLocationEvent>(_onSaveLocationEvent);
  }

  FutureOr<void> _onSaveLocationEvent(
    SaveLocationEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(GettingLocation());
    final saved = await saveCurrentLocation();
    emit(
      saved ? SavedLocation() : FailedToSaveLocation(),
    );
  }
}
