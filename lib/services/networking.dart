import 'dart:convert';
import 'dart:developer';

import 'package:climatik/models/weather_model.dart';
import 'package:http/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class ApiService {
  Future getLocationWeather() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      } else {
        //return await Geolocator.getCurrentPosition();
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        var long = position.latitude;
        print(long);
        var uri =
            'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=18966628b08a83615fea91c56f19fb3c&units=metric';
        var url = Uri.parse(uri);
        var response = await get(url);

        if (response.statusCode == 200) {
          var model = jsonDecode(response.body);

          var rex = WeatherModel.fromJson(model);

          List tempVariables = [
            rex.name,
            rex.main.temp,
            rex.wind.speed,
            rex.weather[0].description,
            rex.main.tempMax,
            rex.main.tempMin
          ];
          return tempVariables;
        } else {
          log(response.reasonPhrase.toString());
        }
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  getCityWeather(String cityName) async {
    try {
      var uri =
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=18966628b08a83615fea91c56f19fb3c&units=metric';
      var url = Uri.parse(uri);
      var response = await get(url);
      if (response.statusCode == 200) {
        var model = jsonDecode(response.body);
        return model;
      }
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

final weatherProvider = Provider((ref) => ApiService());

//var temp = model['main']['temp'];
          // print(model);
          // print(temp);

          // 
          // Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(response.data));
          // print(data);

           // print(rex.length);
          // print(model.map(((e) => WeatherModel.fromJson(e))));

          //print(model);
          // var rex = model.map(((e) => WeatherModel.fromJson(e)));
          //print(rex.main.temp);   

// log(model.toString());
          //log(rex.main.humidity.toString());
          //return rex;
          // log(tempVariables.toString());