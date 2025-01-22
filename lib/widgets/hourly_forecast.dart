import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_hourly.dart';
import 'package:intl/intl.dart';

class HourlyForecast extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyForecast({super.key, required this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.j().format(
                      DateTime.fromMillisecondsSinceEpoch(
                        (weatherDataHourly.hourly[index].time ?? 0) * 1000,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    _getWeatherIcon(weatherDataHourly.hourly[index].icon ?? ''),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${weatherDataHourly.hourly[index].temp?.round()}°',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getWeatherIcon(String icon) {
    switch (icon) {
      case 'clear-day':
        return Icons.wb_sunny;
      case 'clear-night':
        return Icons.nightlight_round;
      case 'rain':
        return Icons.water_drop;
      case 'snow':
        return Icons.ac_unit;
      case 'sleet':
        return Icons.ac_unit;
      case 'wind':
        return Icons.air;
      case 'fog':
        return Icons.cloud;
      case 'cloudy':
        return Icons.cloud;
      case 'partly-cloudy-day':
        return Icons.wb_cloudy;
      case 'partly-cloudy-night':
        return Icons.nights_stay;
      default:
        return Icons.question_mark;
    }
  }
}
