/// ─────────────────────────────────────────────────────────────────────────────
/// ApiEndpoints — Centralized API URL configuration
/// ─────────────────────────────────────────────────────────────────────────────
/// The Weather API base URL and key are defined here for easy configuration.
/// Note: The WeatherService uses its own Dio instance with these values,
/// separate from the app's main Dio configured in [di.dart].
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiEndpoints {
  /// WeatherAPI base URL
  static const String baseUrl = 'https://api.weatherapi.com/v1';

  /// WeatherAPI key — read at runtime from the .env asset file.
  /// If not defined in .env, falls back to the public default key.
  static final String apiKey = dotenv.env['WEATHER_API_KEY'] ?? '';

  /// Current weather endpoint builder
  static String currentWeather(String cityName) =>
      '$baseUrl/current.json?key=$apiKey&q=$cityName';
}
