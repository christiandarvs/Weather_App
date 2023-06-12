class Weather {
  late String cityName;
  late String weatherDesc;
  late num temperature;
  late String countryName;
  late num condition;
  late num pressure;
  late num windSpeed;
  late num visibility;
  late num humidity;
  late num minTemp;
  late num maxTemp;

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

  String getWeatherIcon(num condition) {
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
