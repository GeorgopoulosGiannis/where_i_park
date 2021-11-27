// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../core/domain/usecases/get_current_position.dart' as _i14;
import '../core/domain/usecases/get_last_location.dart' as _i15;
import '../core/domain/usecases/save_current_location.dart' as _i12;
import '../features/add_device/domain/usecases/add_tracking_device.dart' as _i9;
import '../features/add_device/domain/usecases/get_connected_device_subject.dart'
    as _i4;
import '../features/add_device/domain/usecases/load_devices.dart' as _i5;
import '../features/add_device/domain/usecases/load_tracking_devices.dart'
    as _i10;
import '../features/add_device/presentation/bloc/add_device_bloc.dart' as _i13;
import '../features/find_car/domain/usecases/get_location_updates.dart' as _i16;
import '../features/find_car/presentation/bloc/find_car_bloc.dart' as _i18;
import '../features/home/presentation/bloc/home_bloc.dart' as _i17;
import 'bluetooth_manager.dart' as _i3;
import 'location_manager.dart' as _i11;
import 'notification_manager.dart' as _i6;
import 'register_module.dart' as _i19;
import 'storage_manager.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BluetoothManager>(_i3.BluetoothManager());
  gh.lazySingleton<_i4.GetConnectedDeviceSubject>(
      () => _i4.GetConnectedDeviceSubject(get<_i3.BluetoothManager>()));
  gh.lazySingleton<_i5.LoadDevices>(
      () => _i5.LoadDevices(get<_i3.BluetoothManager>()));
  gh.singleton<_i6.NotificationManager>(_i6.NotificationManager());
  await gh.factoryAsync<_i7.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.singleton<_i8.StorageManager>(
      _i8.StorageManager(get<_i7.SharedPreferences>()));
  gh.lazySingleton<_i9.AddTrackingDevice>(
      () => _i9.AddTrackingDevice(get<_i8.StorageManager>()));
  gh.lazySingleton<_i10.LoadTrackingDevices>(
      () => _i10.LoadTrackingDevices(get<_i8.StorageManager>()));
  gh.lazySingleton<_i11.LocationManager>(
      () => _i11.LocationManager(get<_i7.SharedPreferences>()));
  gh.lazySingleton<_i12.SaveCurrentLocation>(
      () => _i12.SaveCurrentLocation(get<_i11.LocationManager>()));
  gh.factory<_i13.AddDeviceBloc>(() => _i13.AddDeviceBloc(
      get<_i9.AddTrackingDevice>(),
      get<_i5.LoadDevices>(),
      get<_i10.LoadTrackingDevices>(),
      get<_i4.GetConnectedDeviceSubject>()));
  gh.lazySingleton<_i14.GetCurrentPosition>(
      () => _i14.GetCurrentPosition(get<_i11.LocationManager>()));
  gh.lazySingleton<_i15.GetLastLocation>(
      () => _i15.GetLastLocation(get<_i11.LocationManager>()));
  gh.lazySingleton<_i16.GetLocationUpdates>(
      () => _i16.GetLocationUpdates(get<_i11.LocationManager>()));
  gh.factory<_i17.HomeBloc>(
      () => _i17.HomeBloc(get<_i12.SaveCurrentLocation>()));
  gh.factory<_i18.FindCarBloc>(() => _i18.FindCarBloc(
      get<_i14.GetCurrentPosition>(),
      get<_i15.GetLastLocation>(),
      get<_i16.GetLocationUpdates>()));
  return get;
}

class _$RegisterModule extends _i19.RegisterModule {}
