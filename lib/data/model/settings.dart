import 'package:weather_app/domain/entities/settings.dart';

class SettingsItem implements Setting {
  SettingsItem(this.isKalvin);
  @override
  bool isKalvin;
}
