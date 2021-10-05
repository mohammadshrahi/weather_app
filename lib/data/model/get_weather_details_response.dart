import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
part 'get_weather_details_response.g.dart';

@JsonSerializable()
class GetWeatherDetailsResponse {
  GetWeatherDetailsResponse({this.consolidatedWeather, this.parent});
  factory GetWeatherDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetWeatherDetailsResponseFromJson(json);
  @JsonKey(name: 'consolidated_weather')
  List<ConsolidatedWeather>? consolidatedWeather;
  RegionItem? parent;
}

@JsonSerializable()
class ConsolidatedWeather implements WeatherItem {
  ConsolidatedWeather(
      {this.airPressure,
      this.applicableDate,
      this.created,
      this.humidity,
      this.id,
      this.maxTemp,
      this.minTemp,
      this.predictability,
      this.theTemp,
      this.visibility,
      this.weatherStateAbbr,
      this.weatherStateName,
      this.windDirection,
      this.windDirectionCompass,
      this.windSpeed});
  factory ConsolidatedWeather.fromJson(Map<String, dynamic> json) =>
      _$ConsolidatedWeatherFromJson(json);

  @override
  int? id;

  @JsonKey(name: 'weather_state_name')
  @override
  String? weatherStateName;

  @JsonKey(name: 'weather_state_abbr')
  @override
  String? weatherStateAbbr;

  @JsonKey(name: 'wind_direction_compass')
  @override
  String? windDirectionCompass;

  @override
  String? created;

  @JsonKey(name: 'applicable_date')
  @override
  String? applicableDate;

  @JsonKey(name: 'min_temp')
  @override
  double? minTemp;

  @JsonKey(name: 'max_temp')
  @override
  double? maxTemp;

  @JsonKey(name: 'the_temp')
  @override
  double? theTemp;

  @JsonKey(name: 'wind_speed')
  @override
  double? windSpeed;

  @JsonKey(name: 'wind_direction')
  @override
  double? windDirection;

  @JsonKey(name: 'air_pressure')
  @override
  double? airPressure;

  @override
  double? humidity;

  @override
  double? visibility;

  @override
  int? predictability;
}
