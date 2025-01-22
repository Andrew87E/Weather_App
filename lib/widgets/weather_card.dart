// lib/widgets/weather_card.dart
import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_current.dart';

class WeatherCard extends StatelessWidget {
  final WeatherDataCurrent weatherData;

  const WeatherCard({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weatherData.current?.temp?.round()}°',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      weatherData.current?.summary ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Icon(
                  _getWeatherIcon(weatherData.current?.icon ?? ''),
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem(
                  context,
                  Icons.water_drop,
                  'Humidity',
                  '${weatherData.current?.humidity}%',
                ),
                _buildDetailItem(
                  context,
                  Icons.air,
                  'Wind',
                  '${weatherData.current?.windSpeed} mph',
                ),
                _buildDetailItem(
                  context,
                  Icons.visibility,
                  'Visibility',
                  '${weatherData.current?.visibility} mi',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
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
