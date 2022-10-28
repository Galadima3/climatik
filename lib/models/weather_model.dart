// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromJson(jsonString);


import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
    WeatherModel({
        required this.weather,
        required this.main,
        required this.wind,
        required this.name,
    });

    final List<Weather> weather;
    final Main main;
    final Wind wind;
    final String name;

    factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "wind": wind.toJson(),
        "name": name,
    };
}

class Main {
    Main({
        required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.humidity,
    });

    final double? temp;
    final double? feelsLike;
    final double? tempMin;
    final double? tempMax;
    final int? humidity;

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"] ?? 0,
        feelsLike: json["feels_like"] ?? 0,
        tempMin: json["temp_min"] ?? 0,
        tempMax: json["temp_max"] ?? 0,
        humidity: json["humidity"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "humidity": humidity,
    };
}

class Weather {
    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    final int? id;
    final String? main;
    final String? description;
    final String? icon;

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"] ?? 'Empty',
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    Wind({
        required this.speed,
        required this.deg,
        required this.gust,
    });

    final double? speed;
    final int? deg;
    final double? gust;

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"] ?? 0,
        deg: json["deg"],
        gust: json["gust"],
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
    };
}

