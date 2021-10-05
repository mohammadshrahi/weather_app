import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/resource/resource.dart';
import 'package:weather_app/domain/entities/region.dart';
import 'package:weather_app/domain/usecases/region/get_user_region.dart';
import 'package:weather_app/domain/usecases/region/get_user_region_params.dart';

part 'location_event.dart';
part 'location_state.dart';

@LazySingleton()
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  GetUserRegion getUserRegion;
  LocationBloc(this.getUserRegion) : super(LocationInitState()) {
    on<LocationEvent>((event, emit) async {
      if (event is LocationGetEvent) {
        await _locationGetEvent(emit);
      }
    });
  }
  Future<void> _locationGetEvent(Emitter<LocationState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    emit(LocationLoadingState());
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    Resource resource = await getUserRegion.call(
        params: GetUserRegionParams(
            latitude: position.latitude, longtitude: position.longitude));

    if (resource is SuccessResource<Region>) {
      emit.call(LocationSuccessState(resource));
    } else if (resource is FailedResource) {
      emit.call(LocationFailedState(resource));
    }

    return;
  }
}
