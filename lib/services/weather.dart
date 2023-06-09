class Weather {
  late String cityName;
  late String weatherDesc;
  late double temperature;
  late String countryName;
  late int condition;
  // late int condition;
  Weather(
      {required this.cityName,
      required this.countryName,
      required this.weatherDesc,
      required this.condition,
      required this.temperature});

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
