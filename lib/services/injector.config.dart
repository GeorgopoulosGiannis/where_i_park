// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../core/domain/usecases/get_current_position.dart' as _i8;
import '../core/domain/usecases/get_last_location.dart' as _i9;
import '../core/domain/usecases/save_current_location.dart' as _i7;
import '../features/find_car/presentation/bloc/find_car_bloc.dart' as _i12;
import '../features/find_car/presentation/widgets/bloc/map_bloc.dart' as _i11;
import '../features/home/presentation/bloc/home_bloc.dart' as _i10;
import 'bluetooth_manager.dart' as _i3;
import 'location_manager.dart' as _i6;
import 'notification_manager.dart' as _i4;
import 'register_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.BluetoothManager>(_i3.BluetoothManager());
  gh.singleton<_i4.NotificationManager>(_i4.NotificationManager());
  await gh.factoryAsync<_i5.SharedPreferences>(() => registerModule.prefs,
      preResolve: true);
  gh.lazySingleton<_i6.LocationManager>(
      () => _i6.LocationManager(get<_i5.SharedPreferences>()));
  gh.lazySingleton<_i7.SaveCurrentLocation>(
      () => _i7.SaveCurrentLocation(get<_i6.LocationManager>()));
  gh.lazySingleton<_i8.GetCurrentPosition>(
      () => _i8.GetCurrentPosition(get<_i6.LocationManager>()));
  gh.lazySingleton<_i9.GetLastLocation>(
      () => _i9.GetLastLocation(get<_i6.LocationManager>()));
  gh.factory<_i10.HomeBloc>(
      () => _i10.HomeBloc(get<_i7.SaveCurrentLocation>()));
  gh.factory<_i11.MapBloc>(() =>
      _i11.MapBloc(get<_i8.GetCurrentPosition>(), get<_i9.GetLastLocation>()));
  gh.factory<_i12.FindCarBloc>(() => _i12.FindCarBloc(
      get<_i8.GetCurrentPosition>(), get<_i9.GetLastLocation>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
