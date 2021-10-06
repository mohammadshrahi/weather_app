// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasources/local/shared.dart' as _i3;
import 'data/datasources/remote/weather_service.dart' as _i7;
import 'data/repositories/settings.dart' as _i6;
import 'data/repositories/weather.dart' as _i12;
import 'di/api_module.dart' as _i17;
import 'domain/repositories/settings.dart' as _i5;
import 'domain/repositories/weather.dart' as _i11;
import 'domain/usecases/region/get_user_region.dart' as _i13;
import 'domain/usecases/settings/get_setting.dart' as _i8;
import 'domain/usecases/settings/set_settings.dart' as _i9;
import 'domain/usecases/weather/get_weather_data.dart' as _i14;
import 'presentation/blocs/home/bloc/home_page_bloc.dart' as _i15;
import 'presentation/blocs/location/bloc/location_bloc.dart' as _i16;
import 'presentation/blocs/settings/bloc/settings_bloc.dart' as _i10;

const String _prod = 'prod';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  gh.lazySingleton<_i3.AppSharedPreferences>(() => _i3.AppSharedPreferences());
  gh.factory<_i4.Dio>(() => apiModule.getDioClient());
  gh.lazySingleton<_i5.SettingsRepository>(
      () => _i6.SettingsRepositoryImpl(get<_i3.AppSharedPreferences>()));
  gh.lazySingleton<_i7.WeatherService>(
      () => _i7.WeatherService(get<_i4.Dio>()));
  gh.lazySingleton<_i8.GetSettings>(
      () => _i8.GetSettings(get<_i5.SettingsRepository>()));
  gh.lazySingleton<_i9.SetSettings>(
      () => _i9.SetSettings(get<_i5.SettingsRepository>()));
  gh.lazySingleton<_i10.SettingsBloc>(
      () => _i10.SettingsBloc(get<_i8.GetSettings>(), get<_i9.SetSettings>()));
  gh.lazySingleton<_i11.WeatherRepository>(
      () => _i12.WeatherRepositoryImpl(get<_i7.WeatherService>()),
      registerFor: {_prod});
  gh.lazySingleton<_i11.WeatherRepository>(
      () => _i12.WeatherRepositoryMock(get<_i7.WeatherService>()),
      registerFor: {_test});
  gh.lazySingleton<_i13.GetUserRegion>(
      () => _i13.GetUserRegion(get<_i11.WeatherRepository>()));
  gh.lazySingleton<_i14.GetWeatherData>(
      () => _i14.GetWeatherData(get<_i11.WeatherRepository>()));
  gh.lazySingleton<_i15.HomePageBloc>(
      () => _i15.HomePageBloc(get<_i14.GetWeatherData>()));
  gh.lazySingleton<_i16.LocationBloc>(
      () => _i16.LocationBloc(get<_i13.GetUserRegion>()));
  return get;
}

class _$ApiModule extends _i17.ApiModule {}
