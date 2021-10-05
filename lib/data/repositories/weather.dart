import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:weather_app/core/resource/http_response_handler.dart';
import 'package:weather_app/data/datasources/remote/weather_service.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/domain/repositories/weather.dart';
import 'package:weather_app/domain/usecases/region/get_user_region_params.dart';
import 'package:weather_app/data/model/get_weather_details_response.dart';

@LazySingleton(env: [Environment.prod], as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  WeatherService service;
  WeatherRepositoryImpl(this.service);
  @override
  Future<Resource> getRegions(double? late, double? long) async {
    // HttpResponse<List<RegionItem>> response =
    //     await service.getRegions('$late,$long');

    return HttpResponseHandler<List<Region>>()
        .handle(service.getRegions('$late,$long'));
  }

  @override
  Future<Resource> getWeatherData(int? woeid) async {
    return HttpResponseHandler<GetWeatherDetailsResponse>()
        .handle(service.getWeatherData(woeid ?? 0));
  }
}

@LazySingleton(env: [Environment.test], as: WeatherRepository)
class WeatherRepositoryMock implements WeatherRepository {
  WeatherService service;
  WeatherRepositoryMock(this.service);
  @override
  Future<Resource> getRegions(double? late, double? long) async {
    return SuccessResource([
      RegionItem(
          distance: 100, locationType: 'city', title: 'Munich', woeid: 676757)
    ]);
  }

  @override
  Future<Resource> getWeatherData(int? woeid) {
    // TODO: implement getWeatherData
    throw UnimplementedError();
  }
}
