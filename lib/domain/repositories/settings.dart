import 'package:weather_app/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Setting> getSettings();
  Future<void> setSettings(Setting setting);
}
