// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../core/domain/usecases/get_connected_device.dart' as _i12;
import '../core/presentation/bloc/app_bloc.dart' as _i19;
import '../features/bonded_devices/data/repositories/bonded_devices_repository_impl.dart'
    as _i22;
import '../features/bonded_devices/domain/repository/bonded_devices_repository.dart'
    as _i21;
import '../features/bonded_devices/domain/usecases/load_bonded_devices.dart'
    as _i26;
import '../features/bonded_devices/presentation/bloc/bonded_devices_bloc.dart'
    as _i27;
import '../features/car_locations/domain/usecases/clear_locations.dart' as _i11;
import '../features/car_locations/presentation/bloc/car_locations_bloc.dart'
    as _i23;
import '../features/cars/data/repositories/car_locations_repository_impl.dart'
    as _i8;
import '../features/cars/data/repositories/car_repository_impl.dart' as _i10;
import '../features/cars/domain/entities/car.dart' as _i24;
import '../features/cars/domain/repositories/car_locations_repository.dart'
    as _i7;
import '../features/cars/domain/repositories/car_repository.dart' as _i9;
import '../features/cars/domain/usecases/get_positions_for_car.dart' as _i14;
import '../features/cars/domain/usecases/get_user_cars.dart' as _i15;
import '../features/cars/domain/usecases/remove_car.dart' as _i17;
import '../features/cars/domain/usecases/save_cars.dart' as _i18;
import '../features/cars/presentation/bloc/cars_bloc.dart' as _i25;
import '../features/home/presentation/bloc/home_bloc.dart' as _i3;
import '../features/map/domain/usecases/get_current_location.dart' as _i13;
import '../features/map/presentation/bloc/map_bloc.dart' as _i16;
import 'bluetooth_manager.dart' as _i20;
import 'location_manager.dart' as _i4;
import 'notification_manager.dart' as _i5;
import 'register_module.dart' as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.HomeBloc>(() => _i3.HomeBloc());
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
  gh.factory<_i16.MapBloc>(() => _i16.MapBloc(
      get<_i13.GetCurrentLocation>(), get<_i14.GetPositionsForCar>()));
  gh.lazySingleton<_i17.RemoveCars>(
      () => _i17.RemoveCars(get<_i9.CarRepository>()));
  gh.lazySingleton<_i18.SaveCars>(
      () => _i18.SaveCars(get<_i9.CarRepository>()));
  gh.singleton<_i19.AppBloc>(_i19.AppBloc(get<_i12.GetConnectedDevice>()));
  gh.singleton<_i20.BluetoothManager>(
      _i20.BluetoothManager(get<_i19.AppBloc>()));
  gh.lazySingleton<_i21.BondedDevicesRepository>(
      () => _i22.BondedDevicesRepositoryImpl(get<_i20.BluetoothManager>()));
  gh.factoryParam<_i23.CarLocationsBloc, _i24.Car?, dynamic>((car, _) =>
      _i23.CarLocationsBloc(
          get<_i11.ClearLocations>(), get<_i14.GetPositionsForCar>(),
          car: car));
  gh.lazySingleton<_i25.CarsBloc>(() => _i25.CarsBloc(
      get<_i15.GetUserCars>(), get<_i18.SaveCars>(), get<_i17.RemoveCars>()));
  gh.lazySingleton<_i26.LoadBondedDevices>(
      () => _i26.LoadBondedDevices(get<_i21.BondedDevicesRepository>()));
  gh.factory<_i27.BondedDevicesBloc>(
      () => _i27.BondedDevicesBloc(get<_i26.LoadBondedDevices>()));
  return get;
}

class _$RegisterModule extends _i28.RegisterModule {}
