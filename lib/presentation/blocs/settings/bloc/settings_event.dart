part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class GetSettingsEvent extends SettingsEvent {}

class SetSettingsEvent extends SettingsEvent {
  SetSettingsEvent(this.isKalvin);

  bool isKalvin;
}
