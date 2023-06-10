import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatefulWidget {
  final String cityName;
  final String countryName;
  final String weatherIcon;
  final double temperature;
  final int pressure;
  final double windSpeed;
  final int visibility;
  final int humidity;
  final double minTemp;
  final double maxTemp;
  final String weatherDescription;

  const LocationScreen({
    super.key,
    required this.cityName,
    required this.countryName,
    required this.temperature,
    required this.weatherIcon,
    required this.pressure,
    required this.windSpeed,
    required this.visibility,
    required this.humidity,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherDescription,
  });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.cityName}, ${widget.countryName}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.weatherIcon,
                style: const TextStyle(fontSize: 100),
                textAlign: TextAlign.center,
              ),
              Text(
                '${widget.weatherDescription[0].toUpperCase()}${widget.weatherDescription.substring(1)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${widget.temperature.toStringAsFixed(0)}°C',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 250,
                child: Card(
                  color: const Color(0xff333742),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.bubble_chart_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.pressure} hpa',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Pressure',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.air,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.windSpeed} mph',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Wind',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.visibility_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.pressure} km',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Visibility',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.water_drop_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.humidity} %',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Humidity',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.thermostat_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.minTemp} °C',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Min Temp',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.thermostat_outlined,
                                  size: 30,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.maxTemp} °C',
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Max Temp',
                                  style:
                                      GoogleFonts.poppins(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
