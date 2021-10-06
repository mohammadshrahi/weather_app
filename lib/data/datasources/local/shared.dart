import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/model/settings.dart';
import 'package:weather_app/domain/entities/settings.dart';

@LazySingleton()
class AppSharedPreferences {
  final String _isKalvinKey = 'isKalvin';
  Future<void> setSettings(Setting setting) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_isKalvinKey, setting.isKalvin);
    return;
  }

  Future<Setting> getSettings() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return SettingsItem(sharedPreferences.getBool(_isKalvinKey) ?? false);
  }
}
