// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/datasources/remote/weather_service.dart' as _i4;
import 'data/repositories/weather.dart' as _i6;
import 'di/api_module.dart' as _i11;
import 'domain/repositories/weather.dart' as _i5;
import 'domain/usecases/region/get_user_region.dart' as _i7;
import 'domain/usecases/weather/get_weather_data.dart' as _i8;
import 'presentation/blocs/home/bloc/home_page_bloc.dart' as _i9;
import 'presentation/blocs/location/bloc/location_bloc.dart' as _i10;

const String _prod = 'prod';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final apiModule = _$ApiModule();
  gh.factory<_i3.Dio>(() => apiModule.getDioClient());
  gh.lazySingleton<_i4.WeatherService>(
      () => _i4.WeatherService(get<_i3.Dio>()));
  gh.lazySingleton<_i5.WeatherRepository>(
      () => _i6.WeatherRepositoryImpl(get<_i4.WeatherService>()),
      registerFor: {_prod});
  gh.lazySingleton<_i5.WeatherRepository>(
      () => _i6.WeatherRepositoryMock(get<_i4.WeatherService>()),
      registerFor: {_test});
  gh.lazySingleton<_i7.GetUserRegion>(
      () => _i7.GetUserRegion(get<_i5.WeatherRepository>()));
  gh.lazySingleton<_i8.GetWeatherData>(
      () => _i8.GetWeatherData(get<_i5.WeatherRepository>()));
  gh.lazySingleton<_i9.HomePageBloc>(
      () => _i9.HomePageBloc(get<_i8.GetWeatherData>()));
  gh.lazySingleton<_i10.LocationBloc>(
      () => _i10.LocationBloc(get<_i7.GetUserRegion>()));
  return get;
}

class _$ApiModule extends _i11.ApiModule {}
