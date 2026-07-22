import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/src/core/network/models/error_model.dart';
import 'package:weather_app/src/features/weather/cubit/weather_cubit.dart';
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';
import 'package:weather_app/src/features/weather/data/service/weather_service.dart';
import 'package:dartz/dartz.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// FakeWeatherService — Standalone mock implementation for unit testing
/// ─────────────────────────────────────────────────────────────────────────────
/// Avoids external HTTP dependencies and database/SharedPreferences latency.
/// Configurable stubs allow testing various success and failure conditions.
class FakeWeatherService extends WeatherServiceImpl {
  Either<ErrorModel, WeatherModel>? getWeatherResult;
  WeatherModel? getCachedWeatherResult;
  String? getLastSearchedCityResult;
  bool clearLastSearchedCityCalled = false;

  @override
  Future<Either<ErrorModel, WeatherModel>> getWeather({
    required String cityName,
  }) async {
    return getWeatherResult ?? const Left(ErrorModel(message: 'Default error'));
  }

  @override
  Future<WeatherModel?> getCachedWeather({required String cityName}) async {
    return getCachedWeatherResult;
  }

  @override
  Future<String?> getLastSearchedCity() async {
    return getLastSearchedCityResult;
  }

  @override
  Future<void> clearLastSearchedCity() async {
    clearLastSearchedCityCalled = true;
  }
}

void main() {
  final di = GetIt.I;

  /// A reusable sample [WeatherModel] for testing.
  final sampleWeatherModel = WeatherModel.fromJson(const {
    'location': {
      'name': 'Cairo',
      'region': 'Al Qahirah',
      'country': 'Egypt',
      'lat': 30.05,
      'lon': 31.25,
      'localtime': '2026-07-22 19:47',
    },
    'current': {
      'last_updated': '2026-07-22 19:30',
      'temp_c': 36.3,
      'temp_f': 97.3,
      'is_day': 1,
      'condition': {
        'text': 'Clear',
        'icon': '//cdn.weatherapi.com/weather/64x64/day/113.png',
        'code': 1000,
      },
      'wind_kph': 34.6,
      'wind_dir': 'NW',
      'pressure_mb': 1007.0,
      'humidity': 37,
      'cloud': 0,
      'feelslike_c': 34.8,
      'vis_km': 10.0,
      'uv': 0.2,
    },
  });

  group('WeatherState', () {
    test('initial state has correct default values', () {
      const state = WeatherState();

      expect(state.status, WeatherStatus.initial);
      expect(state.weatherData, isNull);
      expect(state.message, '');
      expect(state.isOffline, false);
    });

    test('copyWith updates status while preserving other fields', () {
      const state = WeatherState();
      final loadingState = state.copyWith(status: WeatherStatus.loading);

      expect(loadingState.status, WeatherStatus.loading);
      expect(loadingState.message, '');
      expect(loadingState.isOffline, false);
    });

    test('copyWith updates weatherData correctly', () {
      const state = WeatherState();
      final loadedState = state.copyWith(
        status: WeatherStatus.loaded,
        weatherData: sampleWeatherModel,
      );

      expect(loadedState.status, WeatherStatus.loaded);
      expect(loadedState.weatherData, isNotNull);
      expect(loadedState.weatherData!.location.name, 'Cairo');
    });

    test('Equatable comparison checks field equality', () {
      final state1 = WeatherState(
        status: WeatherStatus.loaded,
        weatherData: sampleWeatherModel,
      );
      final state2 = WeatherState(
        status: WeatherStatus.loaded,
        weatherData: sampleWeatherModel,
      );

      expect(state1, equals(state2));
    });
  });

  group('WeatherCubit', () {
    late FakeWeatherService fakeWeatherService;
    late WeatherCubit cubit;

    setUp(() {
      // Set up clean mock environment for each test
      fakeWeatherService = FakeWeatherService();
      
      // Register stub service in GetIt
      di.allowReassignment = true;
      di.registerLazySingleton<WeatherServiceImpl>(() => fakeWeatherService);
      
      cubit = WeatherCubit();
    });

    tearDown(() {
      cubit.close();
      di.reset();
    });

    test('searchWeather emits loading and then loaded status on success', () async {
      fakeWeatherService.getWeatherResult = Right(sampleWeatherModel);

      // Verify initial state
      expect(cubit.state.status, WeatherStatus.initial);

      // Start search and wait for completion
      final future = cubit.searchWeather('Cairo');
      
      // While running, status should transition to loading
      expect(cubit.state.status, WeatherStatus.loading);

      await future;

      // Assert final state
      expect(cubit.state.status, WeatherStatus.loaded);
      expect(cubit.state.weatherData, equals(sampleWeatherModel));
      expect(cubit.state.isOffline, isFalse);
      expect(cubit.state.message, isEmpty);
    });

    test('searchWeather emits error status on network failure if no cache exists', () async {
      fakeWeatherService.getWeatherResult = const Left(
        ErrorModel(message: 'No internet connection'),
      );
      fakeWeatherService.getCachedWeatherResult = null;

      await cubit.searchWeather('Cairo');

      expect(cubit.state.status, WeatherStatus.error);
      expect(cubit.state.message, 'No internet connection');
      expect(cubit.state.weatherData, isNull);
    });

    test('searchWeather loads cached data and flags offline on network failure', () async {
      fakeWeatherService.getWeatherResult = const Left(
        ErrorModel(message: 'No internet connection'),
      );
      fakeWeatherService.getCachedWeatherResult = sampleWeatherModel;

      await cubit.searchWeather('Cairo');

      // The status should still be loaded, but showing offline data
      expect(cubit.state.status, WeatherStatus.loaded);
      expect(cubit.state.weatherData, equals(sampleWeatherModel));
      expect(cubit.state.isOffline, isTrue);
      expect(cubit.state.message, 'Network error. Showing cached data.');
    });

    test('loadLastSearchedCity automatically calls search if city is cached', () async {
      fakeWeatherService.getLastSearchedCityResult = 'London';
      fakeWeatherService.getWeatherResult = Right(sampleWeatherModel);

      await cubit.loadLastSearchedCity();

      // State should have updated for London search
      expect(cubit.state.status, WeatherStatus.loaded);
      expect(cubit.state.weatherData, equals(sampleWeatherModel));
    });

    test('resetWeather clears storage cache and resets state back to initial', () async {
      // First put cubit in loaded state
      fakeWeatherService.getWeatherResult = Right(sampleWeatherModel);
      await cubit.searchWeather('Cairo');
      expect(cubit.state.status, WeatherStatus.loaded);

      // Reset the cubit
      await cubit.resetWeather();

      // Assert state returned to initial
      expect(cubit.state.status, WeatherStatus.initial);
      expect(cubit.state.weatherData, isNull);
      expect(cubit.state.message, isEmpty);
      expect(cubit.state.isOffline, isFalse);

      // Verify service clear cache method was invoked
      expect(fakeWeatherService.clearLastSearchedCityCalled, isTrue);
    });
  });
}
