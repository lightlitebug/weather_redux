import 'package:http/http.dart' as http;

import '../exceptions/weather_exception.dart';
import '../models/custom_error.dart';
import '../models/direct_geocoding.dart';
import '../models/weather.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository._({
    required this.weatherApiServices,
  });

  static final WeatherRepository _instance = WeatherRepository._(
    weatherApiServices: WeatherApiServices(
      httpClient: http.Client(),
    ),
  );

  static WeatherRepository get instance => _instance;

  Future<Weather> fetchWeather(String city) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(city);
      print('directGeocoding: $directGeocoding');

      final Weather tempWeather =
          await weatherApiServices.getWeather(directGeocoding);
      print('tempWeather: $tempWeather');

      final Weather weather = tempWeather.copyWith(
        name: directGeocoding.name,
        country: directGeocoding.country,
      );

      print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(
        errorType: 'WeatherException',
        message: e.message,
      );
    } catch (e) {
      throw CustomError(
        errorType: 'Unknown Error',
        message: e.toString(),
      );
    }
  }
}
