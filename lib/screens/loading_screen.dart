import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('Init State Called');
    getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();

    await location.getLocation();
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=057e14416124ad6da322d52d049ae9d7&units=metric'));
    var jsonData = jsonDecode(response.body);

    debugPrint('$jsonData');
    double temperature = jsonData['main']['temp'];
    String cityName = jsonData['name'];
    String countryName = jsonData['sys']['country'];
    String weatherDesc = jsonData['weather'][0]['description'];
    int condition = jsonData['weather'][0]['id'];
    int pressure = jsonData['main']['pressure'];
    double windSpeed = jsonData['wind']['speed'];
    int visibility = jsonData['visibility'];
    int humidity = jsonData['main']['humidity'];
    num minTemp = jsonData['main']['temp_min'];
    num maxTemp = jsonData['main']['temp_max'];

    Weather weather = Weather(
        countryName: countryName,
        cityName: cityName,
        weatherDesc: weatherDesc,
        condition: condition,
        temperature: temperature,
        pressure: pressure,
        windSpeed: windSpeed,
        visibility: visibility,
        minTemp: minTemp,
        maxTemp: maxTemp,
        humidity: humidity);
    await navigateToWeatherScreen(
        location.latitude,
        location.longitude,
        cityName,
        countryName,
        temperature,
        weather.getWeatherIcon(condition),
        weatherDesc,
        pressure,
        windSpeed,
        visibility,
        humidity,
        minTemp,
        maxTemp);
  }

  Future<void> navigateToWeatherScreen(
    double latitude,
    double longitude,
    String cityName,
    String countryName,
    double temperature,
    String weatherIcon,
    String weatherDesc,
    int pressure,
    double windSpeed,
    int visibility,
    int humidity,
    num minTemp,
    num maxTemp,
  ) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          countryName: countryName,
          weatherIcon: weatherIcon,
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
          temperature: temperature,
          pressure: pressure,
          windSpeed: windSpeed,
          visibility: visibility,
          humidity: humidity,
          maxTemp: maxTemp,
          weatherDesc: weatherDesc,
          minTemp: minTemp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
