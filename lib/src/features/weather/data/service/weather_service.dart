import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/core/network/api_endpoints.dart';
import 'package:weather_app/src/core/network/api_helper.dart';
import 'package:weather_app/src/core/network/dio_manager.dart';
import 'package:weather_app/src/core/network/models/error_model.dart';
import 'package:weather_app/src/core/utils/di.dart';

import '../models/weather_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// WeatherService — Abstract Contract
/// ─────────────────────────────────────────────────────────────────────────────
/// Defines the data-layer interface for weather operations.
/// Following Dependency Inversion, the Cubit depends on this abstraction,
/// not the concrete implementation.
abstract class WeatherService {
  /// Fetches live weather data for a given [cityName].
  /// Returns [Either] an [ErrorModel] on failure or a [WeatherModel] on success.
  Future<Either<ErrorModel, WeatherModel>> getWeather({
    required String cityName,
  });

  /// Retrieves previously cached weather data for [cityName], if available.
  Future<WeatherModel?> getCachedWeather({required String cityName});

  /// Gets the name of the last searched city for restoring state on app startup.
  Future<String?> getLastSearchedCity();

  /// Clears the last searched city from storage.
  Future<void> clearLastSearchedCity();
}

/// ─────────────────────────────────────────────────────────────────────────────
/// WeatherServiceImpl — Concrete Implementation
/// ─────────────────────────────────────────────────────────────────────────────
/// Uses a standalone [Dio] instance because the Weather API has its own
/// base URL, separate from the app's main API configured in [DioManager].
/// Mixes in [ApiHelper] to leverage the standardized error handling via
/// [handleApiRequest].
class WeatherServiceImpl with ApiHelper implements WeatherService {
  /// SharedPreferences key prefix for cached weather data.
  static const String _cachePrefix = 'cached_weather_';

  /// SharedPreferences key for storing the last searched city name.
  static const String _lastCityKey = 'last_searched_city';

  /// ─────────────────────────────────────────────────────────────────────────
  /// getWeather — Fetches live weather and caches on success
  /// ─────────────────────────────────────────────────────────────────────────
  @override
  Future<Either<ErrorModel, WeatherModel>> getWeather({
    required String cityName,
  }) async {
    /// [handleApiRequest] from ApiHelper wraps the network call in a
    /// try-catch, converting DioExceptions into [ErrorModel] on the Left
    /// side, or returning the parsed result on the Right side.

    final result = await handleApiRequest<WeatherModel>(() async {
      final response = await DioManager.get(
        url: ApiEndpoints.currentWeather(cityName),
      );

      return handleResponseError(
        response,
        200,
        WeatherModel.fromJson(response.data),
      );
    });

    result.fold(
      (error) {
        // Caching is skipped on error
      },
      (weatherModel) async {
        final prefs = di<SharedPreferences>();
        final cacheKey = '$_cachePrefix${cityName.toLowerCase()}';
        await prefs.setString(cacheKey, jsonEncode(weatherModel.toJson()));
        await prefs.setString(_lastCityKey, cityName);
      },
    );

    return result;
  }

  /// ─────────────────────────────────────────────────────────────────────────
  /// getCachedWeather — Retrieves offline data from SharedPreferences
  /// ─────────────────────────────────────────────────────────────────────────
  @override
  Future<WeatherModel?> getCachedWeather({required String cityName}) async {
    final prefs = di<SharedPreferences>();
    final cacheKey = '$_cachePrefix${cityName.toLowerCase()}';
    final cachedData = prefs.getString(cacheKey);

    if (cachedData != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(cachedData);
        return WeatherModel.fromJson(json);
      } catch (_) {
        /// If cache data is corrupted, silently return null
        /// so the caller can fall through to the error state.
        return null;
      }
    }
    return null;
  }

  /// ─────────────────────────────────────────────────────────────────────────
  /// getLastSearchedCity — Restores the last city name on app restart
  /// ─────────────────────────────────────────────────────────────────────────
  @override
  Future<String?> getLastSearchedCity() async {
    final prefs = di<SharedPreferences>();
    return prefs.getString(_lastCityKey);
  }

  /// ─────────────────────────────────────────────────────────────────────────
  /// clearLastSearchedCity — Clears the cached city from storage
  /// ─────────────────────────────────────────────────────────────────────────
  @override
  Future<void> clearLastSearchedCity() async {
    final prefs = di<SharedPreferences>();
    await prefs.remove(_lastCityKey);
  }
}
