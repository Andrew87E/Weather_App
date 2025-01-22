class WeatherDataCurrent {
  final Current? current;
  WeatherDataCurrent({this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherDataCurrent(
      current: Current.fromJson(json['currently'] ?? {}),
    );
  }
}

class Current {
  double? temp;
  double? feelsLike;
  int? humidity;
  double? uvIndex;
  double? windSpeed;
  String? icon;
  String? summary;
  double? precipitation;
  int? windBearing;
  double? pressure;
  double? visibility;
  double? cloudCover;

  Current({
    this.temp,
    this.feelsLike,
    this.humidity,
    this.uvIndex,
    this.windSpeed,
    this.icon,
    this.summary,
    this.precipitation,
    this.windBearing,
    this.pressure,
    this.visibility,
    this.cloudCover,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      temp: json['temperature']?.toDouble(),
      feelsLike: json['apparentTemperature']?.toDouble(),
      humidity: (json['humidity']?.toDouble() * 100).toInt(),
      uvIndex: json['uvIndex']?.toDouble(),
      windSpeed: json['windSpeed']?.toDouble(),
      icon: json['icon'],
      summary: json['summary'],
      precipitation: json['precipIntensity']?.toDouble(),
      windBearing: json['windBearing']?.toInt(),
      pressure: json['pressure']?.toDouble(),
      visibility: json['visibility']?.toDouble(),
      cloudCover: json['cloudCover']?.toDouble(),
    );
  }
}
