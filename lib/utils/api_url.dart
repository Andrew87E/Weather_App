import 'package:basic_app/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&units=imperial&appid=$apiKey&exclude=minutely";

  return url;
}
