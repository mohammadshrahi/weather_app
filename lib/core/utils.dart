import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/resources/resources.dart';

class AppConst {
  static const String kApiEndPoint = 'https://www.metaweather.com/api';
  static const String kAssetsEndPoint =
      'https://www.metaweather.com/static/img/weather/';
  static const String kMaterialAppTitle = 'Weather App';
  static const Color kAppPrimaryColor = Color(0xff26495c);
  static const Color kAppSecondaryColor = Color(0xffc4a35a);
  static const double kHeadlineSize1 = 24;
  static const double kHeadlineSize2 = 35;
  static const double kBody2Size = 22;

  static ThemeData getAppThem() {
    ThemeData theme = ThemeData.light();
    return theme.copyWith(
        primaryColor: kAppPrimaryColor,
        colorScheme: theme.colorScheme.copyWith(secondary: kAppPrimaryColor),
        textTheme: theme.textTheme.copyWith(
            headline1: theme.textTheme.headline1?.copyWith(
              fontSize: kHeadlineSize1,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
            headline2: theme.textTheme.headline2?.copyWith(
              fontSize: kHeadlineSize2,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
            headline3: theme.textTheme.headline3?.copyWith(
              fontSize: kHeadlineSize1,
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
            bodyText1: theme.textTheme.bodyText1?.copyWith(
              color: Colors.white,
            ),
            bodyText2: theme.textTheme.bodyText2
                ?.copyWith(color: Colors.white, fontSize: kBody2Size)));
  }
}

class Utils {
  static getAssetsLink(String abr) {
    return '${AppConst.kAssetsEndPoint}$abr.svg';
  }

  static getBgImage(String abr) {
    switch (abr) {
      case 'sn':
      case 'sl':
      case 'h':
        return Gifs.snowing;
      case 's':
      case 'hr':
      case 'lr':
      case 't':
        return Gifs.raining;
      default:
        return Gifs.cloudBlueG;
    }
  }
}

class AppDateUtils {
  DateTime _dateTime;
  AppDateUtils(this._dateTime);
  factory AppDateUtils.fromYYYYMMdd(String date) {
    return AppDateUtils(DateFormat('yyyy-MM-dd').parse(date));
  }
  String getDayOfTheWeek() {
    return DateFormat('EEEE').format(_dateTime);
  }
}
