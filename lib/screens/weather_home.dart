import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_android/models/weather_models.dart';
import 'package:weather_app_android/service/weather_service.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {

  //API KEY
  final _weatherService = WeatherService('2b350f0b469f86986658e9618e3c4293');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    //print errors
    catch (e) {
      print(e);
    }
  }

  // weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; // default

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'clouds':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thudenrstorm':
        return 'assets/thunderstorm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "Loading city..."),

            // // animation
            // Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Lottie.asset('assets/thunder.json'),
            // temperature
            Text('${_weather?.temperature.round().toString()} °C'),

            // weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
