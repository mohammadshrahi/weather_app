import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/data/model/settings.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/presentation/blocs/home/bloc/home_page_bloc.dart';
import 'package:weather_app/presentation/blocs/location/bloc/location_bloc.dart';
import 'package:weather_app/data/model/get_weather_details_response.dart';
import 'package:weather_app/presentation/blocs/settings/bloc/settings_bloc.dart';

class BlocUtils {
  static SettingsSuccessState settingsSuccessState =
      SettingsSuccessState(SettingsItem(true));
  static SuccessResource<Region> locationSuccessResource = SuccessResource(
      RegionItem(
          distance: 1830,
          title: 'Munich',
          woeid: 676757,
          locationType: 'City'));
  static SuccessResource<List<WeatherItem>> weatherSuccessState =
      SuccessResource([ConsolidatedWeather()]);
  static LocationSuccessState kLocationSuccessState =
      LocationSuccessState(locationSuccessResource);
  static HomePageSuccessState homePageSuccessState = HomePageSuccessState(
      ConsolidatedWeather(
        airPressure: 123,
        humidity: 1231,
        theTemp: 11.213,
        maxTemp: 15.231,
        minTemp: 9.13,
        weatherStateAbbr: 'hr',
        windSpeed: 313,
        weatherStateName: 'Raining',
        applicableDate: '1990-10-02',
      ),
      [
        ConsolidatedWeather(
          airPressure: 123,
          humidity: 1231,
          theTemp: 11.213,
          maxTemp: 15.231,
          minTemp: 9.13,
          weatherStateAbbr: 'hr',
          windSpeed: 313,
          weatherStateName: 'Raining',
          applicableDate: '1990-10-02',
        ),
        ConsolidatedWeather(
          airPressure: 23,
          humidity: 323,
          theTemp: 131.213,
          maxTemp: 155.231,
          minTemp: 92.13,
          weatherStateAbbr: 'hr',
          windSpeed: 313,
          weatherStateName: 'Raining',
          applicableDate: '1990-10-02',
        ),
        ConsolidatedWeather(
          airPressure: 123,
          humidity: 1231,
          theTemp: 11.213,
          maxTemp: 15.231,
          minTemp: 9.13,
          weatherStateAbbr: 'hr',
          windSpeed: 313,
          weatherStateName: 'Raining',
          applicableDate: '1990-10-02',
        )
      ]);
}
