import 'package:weather_app/presentation/pages/home_page.dart';
import 'package:weather_app/presentation/pages/settings_page.dart';

class Routes {
  static getRoutes() {
    return {
      kHomePageRoute: (context) => HomePage(),
      kSettingPageRoute: (context) => SettingsPage()
    };
  }

  static const String kHomePageRoute = 'kHomePageRoute';
  static const String kSettingPageRoute = 'kSettingPageRoute';
}
