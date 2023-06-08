import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;

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

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=057e14416124ad6da322d52d049ae9d7&units=metric'));
    var jsonData = jsonDecode(response.body);
    debugPrint('$jsonData');
    var temperature = jsonData['main']['temp'];
    var cityName = jsonData['name'];
    var countryName = jsonData['sys']['country'];
    await navigateToWeatherScreen(location.latitude, location.longitude,
        cityName, countryName, temperature);
  }

  Future<void> navigateToWeatherScreen(double latitude, double longitude,
      String cityName, String countryName, double temperature) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
          countryName: countryName,
          temperature: temperature,
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
