import 'package:basic_app/api/api_key.dart';

String apiURL(var lat, var lon) {
  String url;

  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=37.39454173713587&lon=-122.0798862385229&units=imperial&appid=589d1a71ed61a2bc78e01fd58646b37a&exclude=minutely";

  return url;
}
