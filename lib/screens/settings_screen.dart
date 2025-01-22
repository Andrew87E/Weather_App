import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _useWeatherKit = false;
  final _weatherKitKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _useWeatherKit = prefs.getBool('useWeatherKit') ?? false;
      _weatherKitKeyController.text = prefs.getString('weatherKitKey') ?? '';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useWeatherKit', _useWeatherKit);
    await prefs.setString('weatherKitKey', _weatherKitKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Use WeatherKit API'),
              value: _useWeatherKit,
              onChanged: (bool value) {
                setState(() {
                  _useWeatherKit = value;
                  _saveSettings();
                });
              },
            ),
            const SizedBox(height: 20),
            if (_useWeatherKit) ...[
              const Text('WeatherKit API Key'),
              TextField(
                controller: _weatherKitKeyController,
                decoration: const InputDecoration(
                  hintText: 'Enter your WeatherKit API key',
                ),
                onChanged: (_) => _saveSettings(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
