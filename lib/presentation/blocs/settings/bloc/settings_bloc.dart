import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/data/model/settings.dart';
import 'package:weather_app/domain/entities/settings.dart';
import 'package:weather_app/domain/usecases/settings/get_setting.dart';
import 'package:weather_app/domain/usecases/settings/set_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@LazySingleton()
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  GetSettings getSettings;
  SetSettings setSettings;
  SettingsBloc(this.getSettings, this.setSettings) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is SetSettingsEvent) {
        await setSettings.call(params: SettingsItem(event.isKalvin));
        emit(SettingsSuccessState(SettingsItem(event.isKalvin)));
      } else if (event is GetSettingsEvent) {
        Setting setting = await getSettings.call();
        emit(SettingsSuccessState(SettingsItem(setting.isKalvin)));
      }
    });
  }
  void setSettingState(bool isKalvin) {
    add(SetSettingsEvent(isKalvin));
  }

  void getSettingState() {
    add(GetSettingsEvent());
  }
}
