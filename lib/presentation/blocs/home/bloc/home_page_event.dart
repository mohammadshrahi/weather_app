part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageWeatherGet extends HomePageEvent {
  HomePageWeatherGet(this.woeid);
  int woeid;
}

class HomePageWeatherSelect extends HomePageEvent {
  HomePageWeatherSelect(this.weatherItem, this.index);
  WeatherItem weatherItem;
  int index;
}
