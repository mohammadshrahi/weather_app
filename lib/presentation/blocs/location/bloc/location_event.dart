part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationGetEvent extends LocationEvent {
  @override
  List<Object> get props => super.props;
}
