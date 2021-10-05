import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/dio.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/data/datasources/remote/weather_service.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/data/repositories/weather.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/repositories/weather.dart';
import '../../utils/utils.dart';
import 'weather_repository_test.mocks.dart';
import 'package:dio/dio.dart';

@GenerateMocks([WeatherService])
void main() {
  test('return a List of Regions ', () async {
    WeatherService weatherService = MockWeatherService();

    String lattlong = '11.31231,42.313';
    List<RegionItem> items = [];
    when(weatherService.getRegions(lattlong)).thenAnswer((realInvocation) =>
        Future.value(
            ResponseUtils<List<RegionItem>>().getSuccssResponse(items)));
    WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherService);

    expect(await weatherRepository.getRegions(11.31231, 42.313),
        isA<SuccessResource<List<Region>>>());
  });
  test('return a HttpResponse with 500 status code from weather service',
      () async {
    WeatherService weatherService = MockWeatherService();

    String lattlong = '11.31231,42.313';
    when(weatherService.getRegions(lattlong)).thenAnswer((realInvocation) =>
        Future.value(ResponseUtils<List<RegionItem>>().getFailedResponse([])));
    WeatherRepository weatherRepository = WeatherRepositoryImpl(weatherService);

    expect(await weatherRepository.getRegions(11.31231, 42.313),
        isA<FailedResource>());
  });
}
