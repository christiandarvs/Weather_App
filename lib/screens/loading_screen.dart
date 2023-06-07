import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';

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

  void getLocation() {
    Location location = Location();
    location.getLocation();
    // navigateToWeatherScreen(location.latitude, location.longitude);
  }

  void navigateToWeatherScreen(double latitude, double longitude) async {
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => WeatherScreen(
    //       latitude: latitude,
    //       longitude: longitude,
    //     ),
    //   ),
    // );
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
