part of 'location_bloc.dart';

abstract class LocationState {
  const LocationState();
}

class LocationInitState extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationSuccessState extends LocationState {
  const LocationSuccessState(this.successResource);
  final SuccessResource<Region> successResource;
}

class LocationFailedState extends LocationState {
  const LocationFailedState(this.failedResource);
  final FailedResource failedResource;
}
