import 'package:http/http.dart';
import 'dart:convert';

class worker {
  String location;
  worker({required this.location}) {
    // constructor
    location = this.location;
  }
  String temp = "";
  String humidity = "";
  String air_speed = "";
  String description = "";
  String main = "";
  String icon = "";

  Future<void> getData() async {
    try {
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=4cd8fceb20a67078f0fab8b2941f4bc0");
      Response response = await get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> temp_data = data['main'];

      String getHumidity = temp_data["humidity"].toString(); //Humidity
      double getTemp = temp_data['temp'] - 273.15; //Temperature

      Map<String, dynamic> wind = data['wind'];
      double getAir_speed = wind["speed"] / 0.27777777777778; //Air speed

      List<dynamic> weather_data = data['weather'];
      Map<String, dynamic> weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['description']; //main
      String getDesc = weather_main_data["description"]; //Description

      temp = getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getDesc.toString();
      main = getMain_des;
      icon = weather_main_data["icon"].toString();
    } catch (e) {
      temp = "NA";
      humidity = "NA";
      air_speed = "NA";
      description = "No Description";
      main = "NA";
      icon = "03n";
    }
  }
}
