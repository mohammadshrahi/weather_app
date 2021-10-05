part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageLoadingState extends HomePageState {}

class HomePageFailedState extends HomePageState {
  FailedResource failedResource;
  HomePageFailedState(this.failedResource);
}

class HomePageSuccessState extends HomePageState {
  List<WeatherItem> weatherList;
  WeatherItem weatherItem;
  HomePageSuccessState(this.weatherItem, this.weatherList);
  @override
  List<Object> get props => [weatherItem, ...weatherList];
}
