// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/location_screen.dart';

import 'package:weather_app/services/weather.dart';

class WeatherScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String cityName;
  final String countryName;
  final String weatherIcon;
  final num temperature;
  final num pressure;
  final num windSpeed;
  final num visibility;
  final num humidity;
  final String weatherDesc;
  final num minTemp;
  final num maxTemp;

  const WeatherScreen({
    super.key,
    required this.countryName,
    required this.weatherIcon,
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.temperature,
    required this.pressure,
    required this.windSpeed,
    required this.visibility,
    required this.maxTemp,
    required this.minTemp,
    required this.humidity,
    required this.weatherDesc,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<Weather> weatherData = [];
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    const apiKey = '057e14416124ad6da322d52d049ae9d7';
    final cities = [
      'Paris',
      'Seoul',
      'Tokyo',
      'Taipei',
      'Singapore',
      'Sydney',
      'Manila',
      'Beijing',
      'Ottawa',
      'Buenos Aires',
      'Madrid',
      'Wellington'
    ];

    for (final city in cities) {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final weatherJson = json.decode(response.body);
        final weather = Weather(
            condition: weatherJson['weather'][0]['id'],
            cityName: city,
            countryName: weatherJson['sys']['country'],
            temperature: weatherJson['main']['temp'].toDouble(),
            weatherDesc: weatherJson['weather'][0]['description'],
            pressure: weatherJson['main']['pressure'],
            windSpeed: weatherJson['wind']['speed'],
            visibility: weatherJson['visibility'],
            humidity: weatherJson['main']['humidity'],
            minTemp: weatherJson['main']['temp_min'],
            maxTemp: weatherJson['main']['temp_max']);

        setState(() {
          weatherData.add(weather);
        });
      } else {
        debugPrint('Failed to fetch weather data for $city');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SearchBar(
                  hintText: 'Search City',
                  side: const MaterialStatePropertyAll(
                    BorderSide(color: Color(0xff6f7682)),
                  ),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  overlayColor: const MaterialStatePropertyAll(
                    Color(0xff333742),
                  ),
                  shadowColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  controller: cityController,
                  onChanged: (value) {
                    setState(() {
                      // cityName = value;
                    });
                  },
                  leading: const Icon(
                    Icons.search,
                    color: Color(0xffe3e7e8),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 110,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationScreen(
                              cityName: widget.cityName,
                              countryName: widget.countryName,
                              temperature: widget.temperature,
                              weatherIcon: widget.weatherIcon,
                              pressure: widget.pressure,
                              windSpeed: widget.windSpeed,
                              visibility: widget.visibility,
                              humidity: widget.humidity,
                              minTemp: widget.minTemp,
                              maxTemp: widget.maxTemp,
                              weatherDescription: widget.weatherDesc,
                            ),
                          ));
                    },
                    child: Card(
                      color: const Color(0xff333742),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                widget.weatherIcon,
                                style: const TextStyle(fontSize: 60),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${widget.temperature.toStringAsFixed(0)}°C',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    widget.cityName,
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 20),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Other Locations',
                      style: GoogleFonts.poppins(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: weatherData.length,
                    itemBuilder: (context, index) {
                      final weather = weatherData[index];
                      return SizedBox(
                        height: 110,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(
                                    cityName: weather.cityName,
                                    countryName: weather.countryName,
                                    temperature: weather.temperature,
                                    weatherIcon: weather
                                        .getWeatherIcon(weather.condition),
                                    pressure: weather.pressure,
                                    windSpeed: weather.windSpeed,
                                    visibility: weather.visibility,
                                    humidity: weather.humidity,
                                    minTemp: weather.minTemp,
                                    maxTemp: weather.maxTemp,
                                    weatherDescription: weather.weatherDesc,
                                  ),
                                ));
                          },
                          child: Card(
                            color: const Color(0xff333742),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${weather.temperature.toStringAsFixed(0)}°C',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                            )),
                                        Text(
                                            '${weather.cityName}, ${weather.countryName}',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      weather.getWeatherIcon(weather.condition),
                                      style: const TextStyle(fontSize: 50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
