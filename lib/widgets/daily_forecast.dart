import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_daily.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyForecast({super.key, required this.weatherDataDaily});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              _getWeatherIcon(weatherDataDaily.daily[index].icon ?? ''),
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              DateFormat.EEEE().format(
                DateTime.fromMillisecondsSinceEpoch(
                  (weatherDataDaily.daily[index].time ?? 0) * 1000,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${weatherDataDaily.daily[index].tempMin?.round()}°',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${weatherDataDaily.daily[index].tempMax?.round()}°',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
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
