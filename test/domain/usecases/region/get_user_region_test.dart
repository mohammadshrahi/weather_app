import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/data/repositories/weather.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/repositories/weather.dart';
import 'package:weather_app/domain/usecases/region/get_user_region.dart';
import 'package:weather_app/domain/usecases/region/get_user_region_params.dart';
import 'package:weather_app/resources/resources.dart';
import 'package:test/test.dart';

import 'get_user_region_test.mocks.dart';

@GenerateMocks([WeatherRepositoryImpl])
void main() {
  test('returns a Region if the http call completes successfully', () async {
    double late = 48.1550547;
    double long = 11.4017529;
    final weatherRepository = MockWeatherRepositoryImpl();
    when(weatherRepository.getRegions(late, long)).thenAnswer(
        (realInvocation) => Future.value(SuccessResource([
              RegionItem(
                  distance: 100,
                  title: 'Munich',
                  woeid: 123,
                  locationType: 'city')
            ])));
    GetUserRegion getUserRegion = GetUserRegion(weatherRepository);

    expect(
        await getUserRegion.call(
            params: GetUserRegionParams(latitude: late, longtitude: long)),
        isA<SuccessResource<Region>>());
    expect(
        ((await getUserRegion.call(
                    params:
                        GetUserRegionParams(latitude: late, longtitude: long)))
                .data as Region)
            .locationType,
        'city');
  });

  test('returns a FailedRecours if the http call failed', () async {
    double late = 48.1550547;
    double long = 11.4017529;
    final weatherRepository = MockWeatherRepositoryImpl();
    when(weatherRepository.getRegions(late, long)).thenAnswer(
        (realInvocation) => Future.value(const FailedResource(
            HttpStatus.internalServerError,
            message: 'Something went wrong')));
    GetUserRegion getUserRegion = GetUserRegion(weatherRepository);

    expect(
        await getUserRegion.call(
            params: GetUserRegionParams(latitude: late, longtitude: long)),
        isA<FailedResource>());
    expect(
        (await getUserRegion.call(
                    params:
                        GetUserRegionParams(latitude: late, longtitude: long))
                as FailedResource)
            .message,
        'Something went wrong');
  });
}
