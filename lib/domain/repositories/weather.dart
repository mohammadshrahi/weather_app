import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/domain/entities/region.dart';

abstract class WeatherRepository {
  Future<Resource> getRegions(double? late, double? long);
  Future<Resource> getWeatherData(int? woeid);
}
