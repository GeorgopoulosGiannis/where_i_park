// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../features/bonded_devices/data/repositories/bonded_devices_repository_impl.dart'
    as _i5;
import '../features/bonded_devices/domain/repository/bonded_devices_repository.dart'
    as _i4;
import '../features/bonded_devices/domain/usecases/load_bonded_devices.dart'
    as _i7;
import '../features/bonded_devices/presentation/bloc/bonded_devices_bloc.dart'
    as _i11;
import '../features/cars/data/repositories/car_repository_impl.dart' as _i13;
import '../features/cars/domain/repositories/car_repository.dart' as _i12;
import '../features/cars/domain/usecases/get_user_cars.dart' as _i14;
import '../features/cars/presentation/bloc/cars_bloc.dart' as _i15;
import '../features/home/presentation/bloc/home_bloc.dart' as _i6;
import 'bluetooth_manager.dart' as _i3;
import 'location_manager.dart' as _i8;
import 'notification_manager.dart' as _i9;
import 'register_module.dart' as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BluetoothManager>(_i3.BluetoothManager());
  gh.lazySingleton<_i4.BondedDevicesRepository>(
      () => _i5.BondedDevicesRepositoryImpl(get<_i3.BluetoothManager>()));
  gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc());
  gh.lazySingleton<_i7.LoadBondedDevices>(
      () => _i7.LoadBondedDevices(get<_i4.BondedDevicesRepository>()));
  gh.singleton<_i8.LocationManager>(_i8.LocationManager());
  gh.singleton<_i9.NotificationManager>(_i9.NotificationManager());
  await gh.factoryAsync<_i10.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.factory<_i11.BondedDevicesBloc>(
      () => _i11.BondedDevicesBloc(get<_i7.LoadBondedDevices>()));
  gh.lazySingleton<_i12.CarRepository>(
      () => _i13.CarRepositoryImpl(get<_i10.SharedPreferences>()));
  gh.lazySingleton<_i14.GetUserCars>(
      () => _i14.GetUserCars(get<_i12.CarRepository>()));
  gh.factory<_i15.CarsBloc>(() => _i15.CarsBloc(get<_i14.GetUserCars>()));
  return get;
}

class _$RegisterModule extends _i16.RegisterModule {}
