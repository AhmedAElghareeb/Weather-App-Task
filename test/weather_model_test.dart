import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/src/features/weather/data/models/weather_model.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// WeatherModel Unit Tests
/// ─────────────────────────────────────────────────────────────────────────────
/// Tests the JSON parsing, serialization, and Equatable behavior of all
/// weather model classes.
void main() {
  /// Sample JSON that mirrors the real WeatherAPI response structure.
  final Map<String, dynamic> sampleJson = {
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
  };

  group('WeatherModel', () {
    test('fromJson correctly parses a valid API response', () {
      // Act
      final model = WeatherModel.fromJson(sampleJson);

      // Assert — verify top-level fields are correctly parsed
      expect(model.location.name, 'Cairo');
      expect(model.location.country, 'Egypt');
      expect(model.location.region, 'Al Qahirah');
      expect(model.location.lat, 30.05);
      expect(model.location.lon, 31.25);
      expect(model.current.tempC, 36.3);
      expect(model.current.tempF, 97.3);
      expect(model.current.isDay, 1);
      expect(model.current.humidity, 37);
      expect(model.current.windKph, 34.6);
      expect(model.current.windDir, 'NW');
      expect(model.current.pressureMb, 1007.0);
      expect(model.current.feelslikeC, 34.8);
      expect(model.current.visKm, 10.0);
      expect(model.current.uv, 0.2);
      expect(model.current.cloud, 0);
    });

    test('fromJson correctly parses weather condition', () {
      final model = WeatherModel.fromJson(sampleJson);

      expect(model.current.condition.text, 'Clear');
      expect(
        model.current.condition.icon,
        '//cdn.weatherapi.com/weather/64x64/day/113.png',
      );
      expect(model.current.condition.code, 1000);
    });

    test('toJson produces a valid JSON map', () {
      // Arrange — parse and re-serialize
      final model = WeatherModel.fromJson(sampleJson);
      final json = model.toJson();

      // Assert — verify the round-trip produces equivalent data
      expect(json['location']['name'], 'Cairo');
      expect(json['location']['country'], 'Egypt');
      expect(json['current']['temp_c'], 36.3);
      expect(json['current']['condition']['text'], 'Clear');
      expect(json['current']['humidity'], 37);
    });

    test('toJson → fromJson round-trip preserves data integrity', () {
      // This is crucial for caching: the model must survive serialization
      final original = WeatherModel.fromJson(sampleJson);
      final json = original.toJson();
      final restored = WeatherModel.fromJson(json);

      // Equatable ensures deep equality comparison
      expect(original, equals(restored));
    });

    test('copyWith creates a new instance with updated fields', () {
      final model = WeatherModel.fromJson(sampleJson);

      // Only update the location's name
      final updated = model.copyWith(
        location: model.location.copyWith(name: 'Alexandria'),
      );

      // The name should be changed, but everything else stays the same
      expect(updated.location.name, 'Alexandria');
      expect(updated.location.country, 'Egypt');
      expect(updated.current.tempC, 36.3);

      // The original should remain untouched (immutability check)
      expect(model.location.name, 'Cairo');
    });

    test('Equatable: two models with same data are equal', () {
      final model1 = WeatherModel.fromJson(sampleJson);
      final model2 = WeatherModel.fromJson(sampleJson);

      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('Equatable: two models with different data are not equal', () {
      final model1 = WeatherModel.fromJson(sampleJson);
      final model2 = model1.copyWith(
        location: model1.location.copyWith(name: 'London'),
      );

      expect(model1, isNot(equals(model2)));
    });
  });

  group('LocationModel', () {
    test('fromJson handles null/missing fields gracefully', () {
      // Empty JSON — all fields should use default values
      final model = LocationModel.fromJson({});

      expect(model.name, '');
      expect(model.region, '');
      expect(model.country, '');
      expect(model.lat, 0.0);
      expect(model.lon, 0.0);
      expect(model.localtime, '');
    });
  });

  group('CurrentWeatherModel', () {
    test('fromJson handles null/missing fields gracefully', () {
      final model = CurrentWeatherModel.fromJson({});

      expect(model.tempC, 0.0);
      expect(model.tempF, 0.0);
      expect(model.isDay, 1);
      expect(model.humidity, 0);
      expect(model.windKph, 0.0);
      expect(model.condition.text, '');
    });
  });

  group('WeatherConditionModel', () {
    test('fromJson parses condition correctly', () {
      final model = WeatherConditionModel.fromJson({
        'text': 'Sunny',
        'icon': '//cdn.weatherapi.com/weather/64x64/day/113.png',
        'code': 1000,
      });

      expect(model.text, 'Sunny');
      expect(model.code, 1000);
    });

    test('copyWith updates specific fields only', () {
      final model = WeatherConditionModel.fromJson({
        'text': 'Sunny',
        'icon': '//cdn.weatherapi.com/weather/64x64/day/113.png',
        'code': 1000,
      });

      final updated = model.copyWith(text: 'Cloudy');

      expect(updated.text, 'Cloudy');
      expect(updated.code, 1000); // unchanged
    });
  });
}
