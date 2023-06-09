// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/weather.dart';

class WeatherScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String cityName;
  final String weatherIcon;
  final double temperature;
  const WeatherScreen(
      {super.key,
      required this.weatherIcon,
      required this.latitude,
      required this.longitude,
      required this.cityName,
      required this.temperature});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<Weather> weatherData = [];
  late TextEditingController cityController;
  // String? cityName;
  // late double temperature;
  // late String cityName;
  // late String countryName;
  // late String weatherDesc;

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
      'Manila'
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
        );

        setState(() {
          weatherData.add(weather);
        });
      } else {
        print('Failed to fetch weather data for $city');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                shadowColor: const MaterialStatePropertyAll(Colors.transparent),
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
                height: 130,
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    color: const Color(0xff333742),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.weatherIcon,
                              style: const TextStyle(fontSize: 65),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    '${widget.temperature.toStringAsFixed(0)}°C',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    const Icon(Icons.location_pin),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.cityName,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 20)),
                                  ],
                                )
                              ],
                            ),
                          ],
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
                  const Text('Popular Locations'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  )
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
                      child: Card(
                        color: const Color(0xff333742),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        '${weather.temperature.toStringAsFixed(0)}°C',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        '${weather.weatherDesc[0].toUpperCase()}${weather.weatherDesc.substring(1)}',
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 16)),
                                  ],
                                ),
                                Text(
                                    '${weather.cityName}, ${weather.countryName}',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 16))
                              ],
                            ),
                            Text(
                              weather.getWeatherIcon(weather.condition),
                              style: const TextStyle(fontSize: 50),
                            ),
                          ],
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
    );
  }
}
