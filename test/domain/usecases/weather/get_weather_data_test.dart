import 'dart:io';
import 'dart:ui';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/data/repositories/weather.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/domain/usecases/region/get_user_region.dart';
import 'package:weather_app/domain/usecases/region/get_user_region_params.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data.dart';
import 'package:weather_app/data/model/get_weather_details_response.dart';
import 'package:test/test.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data_params.dart';

import '../region/get_user_region_test.mocks.dart';

@GenerateMocks([WeatherRepositoryImpl])
void main() {
  test(
      'returns a List of weather items if the http call completes successfully',
      () async {
    int woeid = 123;
    final weatherRepository = MockWeatherRepositoryImpl();
    when(weatherRepository.getWeatherData(woeid)).thenAnswer(
        (realInvocation) => Future.value(SuccessResource<List<WeatherItem>>([
              ConsolidatedWeather(),
              ConsolidatedWeather(),
              ConsolidatedWeather(),
              ConsolidatedWeather(),
              ConsolidatedWeather()
            ])));
    GetWeatherData getUserRegion = GetWeatherData(weatherRepository);

    expect(await getUserRegion.call(params: GetWeatherDataParams(woeid)),
        isA<SuccessResource<List<WeatherItem>>>());
  });

  test('returns a FailedRecours if the http call failed', () async {
    int woeid = 123;
    final weatherRepository = MockWeatherRepositoryImpl();
    when(weatherRepository.getWeatherData(woeid)).thenAnswer(
        (realInvocation) => Future.value(FailedResource(HttpStatus.notFound)));
    GetWeatherData getUserRegion = GetWeatherData(weatherRepository);

    expect(await getUserRegion.call(params: GetWeatherDataParams(woeid)),
        isA<FailedResource>());
  });
}
