import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_daily.dart';
import 'package:intl/intl.dart';

class DailyForecastSection extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyForecastSection({Key? key, required this.weatherDataDaily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '7-Day Forecast',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[900]!.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weatherDataDaily.daily.length > 7
                ? 7
                : weatherDataDaily.daily.length,
            itemBuilder: (context, index) {
              var daily = weatherDataDaily.daily[index];
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: index != weatherDataDaily.daily.length - 1
                      ? Border(
                          bottom: BorderSide(
                            color: Colors.grey[800]!,
                            width: 0.5,
                          ),
                        )
                      : null,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          DateFormat.EEEE().format(
                            DateTime.fromMillisecondsSinceEpoch(
                              (daily.time ?? 0) * 1000,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/weather/${daily.icon}.gif",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${daily.tempMin?.round()}°',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${daily.tempMax?.round()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: [
                    const SizedBox(height: 12),
                    if (daily.summary != null)
                      Text(
                        daily.summary!,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (daily.humidity != null)
                          _buildDetailColumn(
                            'Humidity',
                            '${daily.humidity?.round()}%',
                            Icons.water_drop,
                          ),
                        if (daily.precipProbability != null)
                          _buildDetailColumn(
                            'Rain',
                            '${(daily.precipProbability! * 100).round()}%',
                            Icons.umbrella,
                          ),
                        if (daily.cloudCover != null)
                          _buildDetailColumn(
                            'Clouds',
                            '${daily.cloudCover?.round()}%',
                            Icons.cloud,
                          ),
                        if (daily.uvIndex != null)
                          _buildDetailColumn(
                            'UV Index',
                            '${daily.uvIndex?.round()}',
                            Icons.wb_sunny,
                          ),
                      ],
                    ),
                    if (daily.sunrise != null && daily.sunset != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildDetailColumn(
                              'Sunrise',
                              DateFormat.jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  (daily.sunrise ?? 0) * 1000,
                                ),
                              ),
                              Icons.wb_sunny_outlined,
                            ),
                            _buildDetailColumn(
                              'Sunset',
                              DateFormat.jm().format(
                                DateTime.fromMillisecondsSinceEpoch(
                                  (daily.sunset ?? 0) * 1000,
                                ),
                              ),
                              Icons.nights_stay_outlined,
                            ),
                          ],
                        ),
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

  Widget _buildDetailColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF82fa5f),
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
