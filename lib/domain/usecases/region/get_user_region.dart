import 'package:injectable/injectable.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/model/get_regions_response.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/repositories/weather.dart';
import 'package:weather_app/domain/usecases/region/get_user_region_params.dart';

@LazySingleton()
class GetUserRegion implements UseCase<Resource, GetUserRegionParams> {
  WeatherRepository weatherRepository;
  GetUserRegion(this.weatherRepository);
  @override
  Future<Resource> call({GetUserRegionParams? params}) async {
    Resource resource = await weatherRepository.getRegions(
        params?.latitude, params?.longtitude);
    if (resource is SuccessResource) {
      return SuccessResource<Region>(resource.data.first);
    } else {
      return resource;
    }
  }
}
