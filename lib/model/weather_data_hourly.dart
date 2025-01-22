class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) {
    List<dynamic> hourlyData = json['hourly']['data'] ?? [];
    return WeatherDataHourly(
      hourly: hourlyData.map((e) => Hourly.fromJson(e)).toList(),
    );
  }
}

class Hourly {
  int? time;
  double? temp;
  String? icon;
  double? precipitation;
  String? summary;
  double? windSpeed;
  double? precipProbability;
  int? windBearing;
  double? humidity;
  double? cloudCover;

  Hourly({
    this.time,
    this.temp,
    this.icon,
    this.precipitation,
    this.summary,
    this.windSpeed,
    this.precipProbability,
    this.windBearing,
    this.humidity,
    this.cloudCover,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      time: json['time']?.toInt(),
      temp: json['temperature']?.toDouble(),
      icon: json['icon'],
      precipitation: json['precipIntensity']?.toDouble(),
      summary: json['summary'],
      windSpeed: json['windSpeed']?.toDouble(),
      precipProbability: json['precipProbability']?.toDouble(),
      windBearing: json['windBearing']?.toInt(),
      humidity: (json['humidity']?.toDouble() ?? 0) * 100,
      cloudCover: (json['cloudCover']?.toDouble() ?? 0) * 100,
    );
  }
}
