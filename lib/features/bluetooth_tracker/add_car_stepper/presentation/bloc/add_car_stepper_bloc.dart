import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/entities/car.dart';
import 'package:where_i_park/features/bluetooth_tracker/cars/domain/usecases/save_cars.dart';
import 'package:where_i_park/services/location_manager.dart';

part 'add_car_stepper_event.dart';
part 'add_car_stepper_state.dart';

@injectable
class AddCarStepperBloc extends Bloc<AddCarStepperEvent, AddCarStepperState> {
  final SaveCars saveCars;
  final LocationManager locationManager;
  AddCarStepperBloc(
    this.saveCars,
    this.locationManager,
  ) : super(
          const AddCarStepperState(
            selectedCar: null,
            trackMethod: TrackMethod.automatic,
            currentStep: 0,
            status: AddCarStepperStatus.loaded,
          ),
        ) {
    _registerEvents();
  }

  void _registerEvents() {
    on<SelectedCarEvent>(_onSelectedCarEvent);
    on<SelectedMethodEvent>(_onSelectedMethodEvent);
    on<PreviousStepEvent>(_onPreviousStepEvent);
    on<NextStepEvent>(_onNextStepEvent);
    on<SaveCarEvent>(_onSaveCarEvent);
  }

  FutureOr<void> _onSelectedCarEvent(
    SelectedCarEvent event,
    Emitter<AddCarStepperState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCar: event.car,
        currentStep: state.currentStep + 1,
      ),
    );
  }

  FutureOr<void> _onSelectedMethodEvent(
    SelectedMethodEvent event,
    Emitter<AddCarStepperState> emit,
  ) async {
    bool hasPermission = false;
    if (event.method == TrackMethod.notification) {
      hasPermission = await locationManager.getPermissionForManual();
    } else if (event.method == TrackMethod.automatic) {
      hasPermission = await locationManager.getPermissionForAutomatic();
    }
    if (hasPermission) {
      emit(
        state.copyWith(
          selectedCar: Car(
            tracking: event.method,
            name: state.selectedCar!.name,
            address: state.selectedCar!.address,
          ),
          trackMethod: event.method,
        ),
      );
    }
  }

  FutureOr<void> _onPreviousStepEvent(
    PreviousStepEvent event,
    Emitter<AddCarStepperState> emit,
  ) {
    emit(
      state.copyWith(
        currentStep: state.currentStep - 1,
      ),
    );
  }

  FutureOr<void> _onNextStepEvent(
    NextStepEvent event,
    Emitter<AddCarStepperState> emit,
  ) {
    emit(
      state.copyWith(
        currentStep: state.currentStep + 1,
      ),
    );
  }

  FutureOr<void> _onSaveCarEvent(
    SaveCarEvent event,
    Emitter<AddCarStepperState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AddCarStepperStatus.loading,
      ),
    );
    bool hasPermission = false;
    if (state.trackMethod == TrackMethod.notification) {
      hasPermission = await locationManager.getPermissionForManual();
    } else if (state.trackMethod == TrackMethod.automatic) {
      hasPermission = await locationManager.getPermissionForAutomatic();
    }
    if (!hasPermission) {
      emit(
        state.copyWith(
            status: AddCarStepperStatus.error,
            errorMessage: 'Please enable location permissions'),
      );
      return;
    }

    final resultOrFailure = await saveCars(
      [
        state.selectedCar!,
      ],
    );
    emit(
      resultOrFailure.fold(
        (left) => state.copyWith(
          errorMessage: left.message,
          status: AddCarStepperStatus.error,
        ),
        (right) => state.copyWith(
          status: AddCarStepperStatus.saved,
        ),
      ),
    );
  }
}
