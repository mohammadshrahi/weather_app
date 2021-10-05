import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/domain/entities/weather_item.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data.dart';
import 'package:weather_app/domain/usecases/weather/get_weather_data_params.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

@LazySingleton()
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  GetWeatherData getWeatherData;
  HomePageBloc(this.getWeatherData) : super(HomePageLoadingState()) {
    on<HomePageEvent>((event, emit) {
      if (event is HomePageWeatherGet) {
        _getWeatherData(event.woeid);
      } else if (event is HomePageWeatherSelect) {
        emit(HomePageSuccessState(
            event.weatherItem, (state as HomePageSuccessState).weatherList));
      }
    });
  }
  Future<void> _getWeatherData(int woeid) async {
    Resource resource =
        await getWeatherData.call(params: GetWeatherDataParams(woeid));
    if (resource is SuccessResource<List<WeatherItem>>) {
      WeatherItem item;
      if (state is HomePageSuccessState) {
        item = resource.data
            .where((element) =>
                element.applicableDate ==
                (state as HomePageSuccessState).weatherItem.applicableDate)
            .first;
      } else {
        item = resource.data.first;
      }
      emit(HomePageSuccessState(item, resource.data));
    } else if (resource is FailedResource) {
      emit(HomePageFailedState(resource));
    }

    return;
  }
}
