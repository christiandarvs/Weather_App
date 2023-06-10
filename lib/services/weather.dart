class Weather {
  late String cityName;
  late String weatherDesc;
  late double temperature;
  late String countryName;
  late int condition;
  late int pressure;
  late double windSpeed;
  late int visibility;
  late int humidity;
  late double minTemp;
  late double maxTemp;
  // late int condition;
  Weather(
      {required this.cityName,
      required this.countryName,
      required this.weatherDesc,
      required this.condition,
      required this.temperature,
      required this.pressure,
      required this.windSpeed,
      required this.visibility,
      required this.humidity,
      required this.minTemp,
      required this.maxTemp});

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
