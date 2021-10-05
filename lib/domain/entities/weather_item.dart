abstract class WeatherItem {
  int? id;
  String? weatherStateName;
  String? weatherStateAbbr;
  String? windDirectionCompass;
  String? created;
  String? applicableDate;
  double? minTemp;
  double? maxTemp;
  double? theTemp;
  double? windSpeed;
  double? windDirection;
  double? airPressure;
  double? humidity;
  double? visibility;
  int? predictability;
}

extension RoundedData on WeatherItem {
  String getMaxTemp() {
    if (maxTemp != null) {
      return maxTemp!.round().toString();
    }

    return '';
  }

  String getMinTemp() {
    if (minTemp != null) {
      return minTemp!.round().toString();
    }
    return '';
  }

  String getTemp() {
    if (theTemp != null) {
      return theTemp!.round().toString();
    }
    return '';
  }
}
