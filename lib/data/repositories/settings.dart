import 'package:injectable/injectable.dart';
import 'package:weather_app/data/datasources/local/shared.dart';
import 'package:weather_app/domain/entities/settings.dart';
import 'package:weather_app/domain/repositories/settings.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this.appSharedPreferences);
  AppSharedPreferences appSharedPreferences;
  @override
  Future<Setting> getSettings() async {
    return await appSharedPreferences.getSettings();
  }

  @override
  Future<void> setSettings(Setting setting) async {
    await appSharedPreferences.setSettings(setting);
  }
}
