// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "common": {
    "somthing_wrong": "Somthing Went Wrong!Please try again",
    "allow_access": "Allow Location Access",
    "ok": "ok"
  },
  "home": {
    "settings": "Settings",
    "humadity": "Humadity",
    "pressure": "Pressure",
    "wind": "Wind",
    "location_access_message": "Location access is required to fetch location weather! Please change location access permission from the app settings"
  },
  "settings": {
    "kalvin": "Kalvin",
    "celsius": "Celsius"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
