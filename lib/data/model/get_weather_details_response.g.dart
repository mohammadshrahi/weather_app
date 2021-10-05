// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_weather_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWeatherDetailsResponse _$GetWeatherDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetWeatherDetailsResponse(
      consolidatedWeather: (json['consolidated_weather'] as List<dynamic>?)
          ?.map((e) => ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
          .toList(),
      parent: json['parent'] == null
          ? null
          : RegionItem.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetWeatherDetailsResponseToJson(
        GetWeatherDetailsResponse instance) =>
    <String, dynamic>{
      'consolidated_weather': instance.consolidatedWeather,
      'parent': instance.parent,
    };

ConsolidatedWeather _$ConsolidatedWeatherFromJson(Map<String, dynamic> json) =>
    ConsolidatedWeather(
      airPressure: (json['air_pressure'] as num?)?.toDouble(),
      applicableDate: json['applicable_date'] as String?,
      created: json['created'] as String?,
      humidity: (json['humidity'] as num?)?.toDouble(),
      id: json['id'] as int?,
      maxTemp: (json['max_temp'] as num?)?.toDouble(),
      minTemp: (json['min_temp'] as num?)?.toDouble(),
      predictability: json['predictability'] as int?,
      theTemp: (json['the_temp'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      weatherStateAbbr: json['weather_state_abbr'] as String?,
      weatherStateName: json['weather_state_name'] as String?,
      windDirection: (json['wind_direction'] as num?)?.toDouble(),
      windDirectionCompass: json['wind_direction_compass'] as String?,
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ConsolidatedWeatherToJson(
        ConsolidatedWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weather_state_name': instance.weatherStateName,
      'weather_state_abbr': instance.weatherStateAbbr,
      'wind_direction_compass': instance.windDirectionCompass,
      'created': instance.created,
      'applicable_date': instance.applicableDate,
      'min_temp': instance.minTemp,
      'max_temp': instance.maxTemp,
      'the_temp': instance.theTemp,
      'wind_speed': instance.windSpeed,
      'wind_direction': instance.windDirection,
      'air_pressure': instance.airPressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'predictability': instance.predictability,
    };
