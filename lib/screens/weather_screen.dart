// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/services/country.dart';

class WeatherScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String cityName;
  final double temperature;
  const WeatherScreen(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.cityName,
      required this.temperature});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
    getLocation();
  }

  Future getLocation() async {
    // var response = await http.get(Uri.parse(
    //     'https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=057e14416124ad6da322d52d049ae9d7&units=metric'));
    // debugPrint(jsonDecode(response.body));
    // return jsonDecode(response.body);
    List countries = [
      Country(cityName: 'Paris', weatherDesc: 'Sunny', temperature: 20),
      Country(cityName: 'Japan', weatherDesc: 'Rainy', temperature: 18),
    ];
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=057e14416124ad6da322d52d049ae9d7&units=metric'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getLocation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                        height: 130,
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            color: const Color(0xff333742),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      '⛅',
                                      style: TextStyle(fontSize: 65),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                                    color: Colors.white,
                                                    fontSize: 20)),
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
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 110,
                              child: Card(
                                color: const Color(0xff333742),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                '${snapshot.data['main']['temp']}°C'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text('weatherDesc'),
                                          ],
                                        ),
                                        Text(snapshot.data['name'])
                                      ],
                                    ),
                                    const Text(
                                      '⛅',
                                      style: TextStyle(fontSize: 65),
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
          return const Scaffold();
        });
  }
}
