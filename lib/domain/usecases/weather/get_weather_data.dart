import 'package:injectable/injectable.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/domain/repositories/weather.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data_params.dart';
import 'package:weather_app/data/model/get_weather_details_response.dart';

@LazySingleton()
class GetWeatherData implements UseCase<Resource, GetWeatherDataParams> {
  WeatherRepository weatherRepository;
  GetWeatherData(this.weatherRepository);
  @override
  Future<Resource> call({GetWeatherDataParams? params}) async {
    Resource resource = await weatherRepository.getWeatherData(params?.woeid);
    if (resource is SuccessResource<GetWeatherDetailsResponse>) {
      return SuccessResource<List<WeatherItem>>(
          resource.data.consolidatedWeather ?? []);
    } else {
      return resource;
    }
  }
}
