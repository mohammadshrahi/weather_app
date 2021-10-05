import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/core/utils.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/data/model/get_weather_details_response.dart';

import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data.dart';

part 'weather_service.g.dart';

@LazySingleton()
@RestApi(baseUrl: AppConst.kApiEndPoint)
abstract class WeatherService {
  @factoryMethod
  factory WeatherService(Dio dio) = _WeatherService;

  @GET('/location/search/')
  Future<HttpResponse<List<RegionItem>>> getRegions(
      @Query('lattlong') String lattlong);

  @GET('/api/location/{woeid}')
  Future<HttpResponse<GetWeatherDetailsResponse>> getWeatherData(
      @Path('woeid') int woeid);
}
