import 'package:equatable/equatable.dart';

/// Top-level model representing the complete response from the WeatherAPI.
/// Implements [Equatable] for value equality comparison, which is essential
/// for effective BLoC state management and avoiding unnecessary UI rebuilds.
class WeatherModel extends Equatable {
  /// Contains geographical and temporal information about the requested location.
  final LocationModel location;

  /// Contains the actual weather conditions.
  final CurrentWeatherModel current;

  const WeatherModel({
    required this.location,
    required this.current,
  });

  /// Factory constructor to create a [WeatherModel] from a JSON map.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: LocationModel.fromJson(json['location'] ?? {}),
      current: CurrentWeatherModel.fromJson(json['current'] ?? {}),
    );
  }

  /// Converts the [WeatherModel] back to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'current': current.toJson(),
    };
  }

  /// Creates a new instance of [WeatherModel] with updated properties.
  WeatherModel copyWith({
    LocationModel? location,
    CurrentWeatherModel? current,
  }) {
    return WeatherModel(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  @override
  List<Object?> get props => [location, current];
}

/// Represents the geographical location of the weather data.
class LocationModel extends Equatable {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String localtime;

  const LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.localtime,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String? ?? '',
      region: json['region'] as String? ?? '',
      country: json['country'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      localtime: json['localtime'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'localtime': localtime,
    };
  }

  LocationModel copyWith({
    String? name,
    String? region,
    String? country,
    double? lat,
    double? lon,
    String? localtime,
  }) {
    return LocationModel(
      name: name ?? this.name,
      region: region ?? this.region,
      country: country ?? this.country,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      localtime: localtime ?? this.localtime,
    );
  }

  @override
  List<Object?> get props => [name, region, country, lat, lon, localtime];
}

/// Represents the current weather conditions.
class CurrentWeatherModel extends Equatable {
  final double tempC;
  final double tempF;
  /// 1 for day, 0 for night
  final int isDay;
  final WeatherConditionModel condition;
  final double windKph;
  final String windDir;
  final double pressureMb;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double visKm;
  final double uv;
  final String lastUpdated;

  const CurrentWeatherModel({
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windKph,
    required this.windDir,
    required this.pressureMb,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.visKm,
    required this.uv,
    required this.lastUpdated,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0,
      tempF: (json['temp_f'] as num?)?.toDouble() ?? 0.0,
      isDay: json['is_day'] as int? ?? 1,
      condition: WeatherConditionModel.fromJson(json['condition'] ?? {}),
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0,
      windDir: json['wind_dir'] as String? ?? '',
      pressureMb: (json['pressure_mb'] as num?)?.toDouble() ?? 0.0,
      humidity: json['humidity'] as int? ?? 0,
      cloud: json['cloud'] as int? ?? 0,
      feelslikeC: (json['feelslike_c'] as num?)?.toDouble() ?? 0.0,
      visKm: (json['vis_km'] as num?)?.toDouble() ?? 0.0,
      uv: (json['uv'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['last_updated'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp_c': tempC,
      'temp_f': tempF,
      'is_day': isDay,
      'condition': condition.toJson(),
      'wind_kph': windKph,
      'wind_dir': windDir,
      'pressure_mb': pressureMb,
      'humidity': humidity,
      'cloud': cloud,
      'feelslike_c': feelslikeC,
      'vis_km': visKm,
      'uv': uv,
      'last_updated': lastUpdated,
    };
  }

  CurrentWeatherModel copyWith({
    double? tempC,
    double? tempF,
    int? isDay,
    WeatherConditionModel? condition,
    double? windKph,
    String? windDir,
    double? pressureMb,
    int? humidity,
    int? cloud,
    double? feelslikeC,
    double? visKm,
    double? uv,
    String? lastUpdated,
  }) {
    return CurrentWeatherModel(
      tempC: tempC ?? this.tempC,
      tempF: tempF ?? this.tempF,
      isDay: isDay ?? this.isDay,
      condition: condition ?? this.condition,
      windKph: windKph ?? this.windKph,
      windDir: windDir ?? this.windDir,
      pressureMb: pressureMb ?? this.pressureMb,
      humidity: humidity ?? this.humidity,
      cloud: cloud ?? this.cloud,
      feelslikeC: feelslikeC ?? this.feelslikeC,
      visKm: visKm ?? this.visKm,
      uv: uv ?? this.uv,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
        tempC,
        tempF,
        isDay,
        condition,
        windKph,
        windDir,
        pressureMb,
        humidity,
        cloud,
        feelslikeC,
        visKm,
        uv,
        lastUpdated,
      ];
}

/// Represents the visual condition of the weather (e.g., Clear, Cloudy).
class WeatherConditionModel extends Equatable {
  final String text;
  /// The icon URL. From API it comes as '//cdn.weatherapi.com/...'.
  final String icon;
  final int code;

  const WeatherConditionModel({
    required this.text,
    required this.icon,
    required this.code,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
      text: json['text'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      code: json['code'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon,
      'code': code,
    };
  }

  WeatherConditionModel copyWith({
    String? text,
    String? icon,
    int? code,
  }) {
    return WeatherConditionModel(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [text, icon, code];
}
