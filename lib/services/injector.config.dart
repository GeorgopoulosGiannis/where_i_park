// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../core/domain/usecases/get_connected_device.dart' as _i12;
import '../core/presentation/bloc/app_bloc.dart' as _i23;
import '../features/bluetooth_tracker/add_car_stepper/presentation/bloc/add_car_stepper_bloc.dart'
    as _i22;
import '../features/bluetooth_tracker/bonded_devices/data/repositories/bonded_devices_repository_impl.dart'
    as _i26;
import '../features/bluetooth_tracker/bonded_devices/domain/repository/bonded_devices_repository.dart'
    as _i25;
import '../features/bluetooth_tracker/bonded_devices/domain/usecases/load_bonded_devices.dart'
    as _i31;
import '../features/bluetooth_tracker/bonded_devices/presentation/bloc/bonded_devices_bloc.dart'
    as _i33;
import '../features/bluetooth_tracker/car_locations/domain/usecases/clear_locations.dart'
    as _i11;
import '../features/bluetooth_tracker/car_locations/presentation/bloc/car_locations_bloc.dart'
    as _i27;
import '../features/bluetooth_tracker/cars/data/repositories/car_locations_repository_impl.dart'
    as _i8;
import '../features/bluetooth_tracker/cars/data/repositories/car_repository_impl.dart'
    as _i10;
import '../features/bluetooth_tracker/cars/domain/entities/car.dart' as _i28;
import '../features/bluetooth_tracker/cars/domain/repositories/car_locations_repository.dart'
    as _i7;
import '../features/bluetooth_tracker/cars/domain/repositories/car_repository.dart'
    as _i9;
import '../features/bluetooth_tracker/cars/domain/usecases/get_positions_for_car.dart'
    as _i14;
import '../features/bluetooth_tracker/cars/domain/usecases/get_user_cars.dart'
    as _i15;
import '../features/bluetooth_tracker/cars/domain/usecases/remove_car.dart'
    as _i19;
import '../features/bluetooth_tracker/cars/domain/usecases/save_cars.dart'
    as _i20;
import '../features/bluetooth_tracker/cars/presentation/bloc/cars_bloc.dart'
    as _i29;
import '../features/bluetooth_tracker/map/domain/usecases/get_current_location.dart'
    as _i13;
import '../features/bluetooth_tracker/map/presentation/bloc/map_bloc.dart'
    as _i18;
import '../features/bluetooth_tracker/services/bluetooth_manager.dart' as _i24;
import '../features/home/presentation/cubit/home_cubit.dart' as _i3;
import '../features/manual_tracker/data/repositories/manual_tracker_repo_impl.dart'
    as _i17;
import '../features/manual_tracker/domain/repositories/manual_tracker_repo.dart'
    as _i16;
import '../features/manual_tracker/domain/usecases/get_last_manual.dart'
    as _i30;
import '../features/manual_tracker/domain/usecases/save_current_location.dart'
    as _i21;
import '../features/manual_tracker/presentation/cubit/manual_tracker_cubit.dart'
    as _i32;
import 'location_manager.dart' as _i4;
import 'notification_manager.dart' as _i5;
import 'register_module.dart' as _i34; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.HomeCubit>(() => _i3.HomeCubit());
  gh.lazySingleton<_i4.LocationManager>(() => _i4.LocationManager());
  gh.singleton<_i5.NotificationManager>(_i5.NotificationManager());
  await gh.factoryAsync<_i6.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i7.CarLocationsRepository>(
      () => _i8.CarLocationsRepositoryImpl(get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i9.CarRepository>(
      () => _i10.CarRepositoryImpl(get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i11.ClearLocations>(
      () => _i11.ClearLocations(get<_i7.CarLocationsRepository>()));
  gh.lazySingleton<_i12.GetConnectedDevice>(
      () => _i12.GetConnectedDevice(get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i13.GetCurrentLocation>(
      () => _i13.GetCurrentLocation(get<_i4.LocationManager>()));
  gh.lazySingleton<_i14.GetPositionsForCar>(
      () => _i14.GetPositionsForCar(get<_i7.CarLocationsRepository>()));
  gh.lazySingleton<_i15.GetUserCars>(
      () => _i15.GetUserCars(get<_i9.CarRepository>()));
  gh.lazySingleton<_i16.ManualTrackerRepository>(() =>
      _i17.ManualTrackerRepoImpl(
          get<_i13.GetCurrentLocation>(), get<_i6.SharedPreferences>()));
  gh.factory<_i18.MapBloc>(() => _i18.MapBloc(
      get<_i13.GetCurrentLocation>(), get<_i14.GetPositionsForCar>()));
  gh.lazySingleton<_i19.RemoveCars>(() => _i19.RemoveCars(
      get<_i9.CarRepository>(), get<_i7.CarLocationsRepository>()));
  gh.lazySingleton<_i20.SaveCars>(
      () => _i20.SaveCars(get<_i9.CarRepository>()));
  gh.lazySingleton<_i21.SaveCurrentLocation>(
      () => _i21.SaveCurrentLocation(get<_i16.ManualTrackerRepository>()));
  gh.factory<_i22.AddCarStepperBloc>(() =>
      _i22.AddCarStepperBloc(get<_i20.SaveCars>(), get<_i4.LocationManager>()));
  gh.singleton<_i23.AppBloc>(_i23.AppBloc(get<_i12.GetConnectedDevice>()));
  gh.singleton<_i24.BluetoothManager>(
      _i24.BluetoothManager(get<_i23.AppBloc>()));
  gh.lazySingleton<_i25.BondedDevicesRepository>(
      () => _i26.BondedDevicesRepositoryImpl(get<_i24.BluetoothManager>()));
  gh.factoryParam<_i27.CarLocationsBloc, _i28.Car?, dynamic>((car, _) =>
      _i27.CarLocationsBloc(
          get<_i11.ClearLocations>(), get<_i14.GetPositionsForCar>(),
          car: car));
  gh.lazySingleton<_i29.CarsBloc>(() => _i29.CarsBloc(
      get<_i15.GetUserCars>(), get<_i20.SaveCars>(), get<_i19.RemoveCars>()));
  gh.lazySingleton<_i30.GetLastManual>(
      () => _i30.GetLastManual(get<_i16.ManualTrackerRepository>()));
  gh.lazySingleton<_i31.LoadBondedDevices>(
      () => _i31.LoadBondedDevices(get<_i25.BondedDevicesRepository>()));
  gh.factory<_i32.ManualTrackerCubit>(() => _i32.ManualTrackerCubit(
      get<_i13.GetCurrentLocation>(),
      get<_i21.SaveCurrentLocation>(),
      get<_i30.GetLastManual>()));
  gh.factory<_i33.BondedDevicesBloc>(
      () => _i33.BondedDevicesBloc(get<_i31.LoadBondedDevices>()));
  return get;
}

class _$RegisterModule extends _i34.RegisterModule {}
