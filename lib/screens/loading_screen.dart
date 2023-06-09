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
    var temperature = jsonData['main']['temp'];
    var cityName = jsonData['name'];
    var countryName = jsonData['sys']['country'];
    var weatherDesc = jsonData['weather'][0]['description'];
    var condition = jsonData['weather'][0]['id'];
    Weather weather = Weather(
        countryName: countryName,
        cityName: cityName,
        weatherDesc: weatherDesc,
        condition: condition,
        temperature: temperature);
    await navigateToWeatherScreen(location.latitude, location.longitude,
        cityName, countryName, temperature, weather.getWeatherIcon(condition));

    // sub-countries
    // const apiKey = '057e14416124ad6da322d52d049ae9d7';
    // final cities = ['Japan', 'Korea', 'Paris', 'Thailand', 'China'];

    // for (final city in cities) {
    //   final url =
    //       'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    //   final response = await http.get(Uri.parse(url));

    //   if (response.statusCode == 200) {
    //     final weatherJson = json.decode(response.body);
    //     final weather = Weather(
    //       cityName: city,
    //       temperature: weatherJson['main']['temp'].toDouble(),
    //       weatherDesc: weatherJson['weather'][0]['description'],
    //     );
    //   } else {
    //     print('Failed to fetch weather data for $city');
    //   }
    //   await navigateToWeatherScreen(location.latitude, location.longitude,
    //       cityName, countryName, temperature);
    // }
  }

  Future<void> navigateToWeatherScreen(
      double latitude,
      double longitude,
      String cityName,
      String countryName,
      double temperature,
      String weatherIcon) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          weatherIcon: weatherIcon,
          latitude: latitude,
          longitude: longitude,
          cityName: cityName,
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
