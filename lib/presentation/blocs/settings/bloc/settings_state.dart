part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsSuccessState extends SettingsState {
  SettingsSuccessState(this.setting);
  Setting setting;
  @override
  List<Object?> get props => [setting.isKalvin];
}
