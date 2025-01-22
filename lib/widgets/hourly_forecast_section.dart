import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_hourly.dart';
import 'package:intl/intl.dart';

class HourlyForecastSection extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyForecastSection({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hourly Forecast',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: Colors.grey[900]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weatherDataHourly.hourly.length > 24
                ? 24
                : weatherDataHourly.hourly.length,
            itemBuilder: (context, index) {
              var hourly = weatherDataHourly.hourly[index];
              return Container(
                width: 100,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat.j().format(
                        DateTime.fromMillisecondsSinceEpoch(
                          (hourly.time ?? 0) * 1000,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Image.asset(
                      "assets/weather/${hourly.icon}.gif",
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      '${hourly.temp?.round()}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop,
                          color: const Color(0xFF82fa5f),
                          size: 12,
                        ),
                        Text(
                          ' ${(hourly.precipitation ?? 0 * 100).round()}%',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.air,
                          color: const Color(0xFF82fa5f),
                          size: 12,
                        ),
                        Text(
                          ' ${hourly.windSpeed?.round()}mph',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
