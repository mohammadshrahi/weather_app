part of 'settings_bloc.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {}

class SettingsSuccessState extends SettingsState {
  SettingsSuccessState(this.setting);
  Setting setting;
}
