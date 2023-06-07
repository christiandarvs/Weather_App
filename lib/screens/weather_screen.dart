import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const WeatherScreen(
      {super.key, required this.latitude, required this.longitude});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late TextEditingController cityController;
  String? cityName;

  @override
  void initState() {
    super.initState();
    cityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    cityName = value;
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
                height: 140,
                child: InkWell(
                  onTap: () {},
                  child: const Card(
                    color: Color(0xff333742),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '⛅',
                              style: TextStyle(fontSize: 65),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('19°C'),
                                Row(
                                  children: [
                                    Icon(Icons.location_pin),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Helsinki, Finland'),
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
              Text('${widget.latitude}'),
              Text('${widget.longitude}'),
            ],
          ),
        ),
      ),
    );
  }
}
