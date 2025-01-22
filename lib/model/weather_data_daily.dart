class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) {
    List<dynamic> dailyData = json['daily']['data'] ?? [];
    return WeatherDataDaily(
      daily: dailyData.map((e) => Daily.fromJson(e)).toList(),
    );
  }
}

class Daily {
  int? time;
  double? tempMax;
  double? tempMin;
  String? icon;
  String? summary;
  double? precipitation;
  int? sunrise;
  int? sunset;
  double? moonPhase;
  double? precipProbability;
  double? windSpeed;
  int? windBearing;
  double? humidity;
  double? cloudCover;
  double? pressure;
  double? uvIndex;

  Daily({
    this.time,
    this.tempMax,
    this.tempMin,
    this.icon,
    this.summary,
    this.precipitation,
    this.sunrise,
    this.sunset,
    this.moonPhase,
    this.precipProbability,
    this.windSpeed,
    this.windBearing,
    this.humidity,
    this.cloudCover,
    this.pressure,
    this.uvIndex,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: json['time']?.toInt(),
      tempMax: json['temperatureMax']?.toDouble(),
      tempMin: json['temperatureMin']?.toDouble(),
      icon: json['icon'],
      summary: json['summary'],
      precipitation: json['precipIntensity']?.toDouble(),
      sunrise: json['sunriseTime']?.toInt(),
      sunset: json['sunsetTime']?.toInt(),
      moonPhase: json['moonPhase']?.toDouble(),
      precipProbability: json['precipProbability']?.toDouble(),
      windSpeed: json['windSpeed']?.toDouble(),
      windBearing: json['windBearing']?.toInt(),
      humidity: (json['humidity']?.toDouble() ?? 0) * 100,
      cloudCover: (json['cloudCover']?.toDouble() ?? 0) * 100,
      pressure: json['pressure']?.toDouble(),
      uvIndex: json['uvIndex']?.toDouble(),
    );
  }
}
