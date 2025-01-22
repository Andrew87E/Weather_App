// lib/widgets/current_weather_section.dart
import 'package:flutter/material.dart';
import 'package:basic_app/model/weather_data_current.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CurrentWeatherSection extends StatelessWidget {
  final WeatherDataCurrent weather;

  const CurrentWeatherSection({Key? key, required this.weather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Main temperature and icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.current?.temp?.round()}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    weather.current?.summary ?? '',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Image.asset(
                "assets/weather/${weather.current?.icon}.gif",
                height: 80,
                width: 80,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Comfort level section
          Column(
            children: [
              Text(
                "Comfort Level",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Humidity circle
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      initialValue:
                          weather.current?.humidity?.toDouble() ?? 0.0,
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 8,
                          progressBarWidth: 8,
                          handlerSize: 0,
                        ),
                        size: 100,
                        animationEnabled: true,
                        customColors: CustomSliderColors(
                          trackColor: Colors.grey[800],
                          progressBarColors: [
                            const Color(0xFF82fa5f),
                            const Color(0xFF82fa5f),
                          ],
                        ),
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          bottomLabelText: "Humidity",
                          bottomLabelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // UV Index circle
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SleekCircularSlider(
                      min: 0,
                      max: 11,
                      initialValue: weather.current?.uvIndex?.toDouble() ?? 0.0,
                      appearance: CircularSliderAppearance(
                        customWidths: CustomSliderWidths(
                          trackWidth: 8,
                          progressBarWidth: 8,
                          handlerSize: 0,
                        ),
                        size: 100,
                        animationEnabled: true,
                        customColors: CustomSliderColors(
                          trackColor: Colors.grey[800],
                          progressBarColors: [
                            const Color(0xFF82fa5f),
                            const Color(0xFF82fa5f),
                          ],
                        ),
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          bottomLabelText: "UV Index",
                          bottomLabelStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Additional weather details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailColumn(
                'Wind',
                '${weather.current?.windSpeed} mph',
                Icons.air,
              ),
              _buildDetailColumn(
                'Visibility',
                '${weather.current?.visibility} mi',
                Icons.visibility,
              ),
              _buildDetailColumn(
                'Cloud Cover',
                '${weather.current?.cloudCover}%',
                Icons.cloud,
              ),
              _buildDetailColumn(
                'Pressure',
                '${weather.current?.pressure} hPa',
                Icons.speed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF82fa5f), size: 24),
        const SizedBox(height: 8),
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
