import 'package:weather_app/src/core/utils/di.dart';
import '../data/service/weather_service.dart';
import '../data/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

/// Cubit responsible for managing the state of the Weather feature.
/// Handles fetching live data, falling back to cache, and managing initial startup flow.
class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherState());

  /// Obtains the [WeatherServiceImpl] instance from the dependency injection container.
  final WeatherServiceImpl _weatherService = di<WeatherServiceImpl>();

  /// Helper to get the cubit instance easily from the widget tree.
  static WeatherCubit get(context) => BlocProvider.of<WeatherCubit>(context);

  /// Initiates a fetch operation for the provided [cityName].
  Future<void> searchWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;
    
    // Emit loading state to trigger the UI spinner
    emit(state.copyWith(status: WeatherStatus.loading, isOffline: false));

    // Execute the network request
    final result = await _weatherService.getWeather(cityName: cityName);

    dynamic errorResult;
    WeatherModel? successResult;

    result.fold(
      (error) => errorResult = error,
      (data) => successResult = data,
    );

    if (errorResult != null) {
      // The network request failed. Attempt to load cached data for this city.
      final cachedWeather =
          await _weatherService.getCachedWeather(cityName: cityName);

      if (cachedWeather != null) {
        // If cache exists, emit loaded state but flag it as offline
        emit(state.copyWith(
          status: WeatherStatus.loaded,
          weatherData: cachedWeather,
          isOffline: true,
          message: 'Network error. Showing cached data.',
        ));
      } else {
        // If no cache, emit the actual error state
        emit(state.copyWith(
          status: WeatherStatus.error,
          message: errorResult.message ??
              'An error occurred while fetching weather.',
        ));
      }
    } else if (successResult != null) {
      // Success: emit loaded state with fresh data
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weatherData: successResult,
        isOffline: false,
        message: '',
      ));
    }
  }

  /// Called on startup to restore the user's context by fetching the last searched city.
  Future<void> loadLastSearchedCity() async {
    final lastCity = await _weatherService.getLastSearchedCity();
    if (lastCity != null && lastCity.isNotEmpty) {
      // If a previous city was found, automatically search for it
      await searchWeather(lastCity);
    }
  }

  /// Resets the weather state back to initial and clears the last searched city storage.
  Future<void> resetWeather() async {
    await _weatherService.clearLastSearchedCity();
    emit(const WeatherState());
  }
}
