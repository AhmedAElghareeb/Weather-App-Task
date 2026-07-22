part of 'weather_cubit.dart';

/// Represents the possible status states of the weather fetch operation.
enum WeatherStatus { initial, loading, loaded, error }

/// Represents the state of the weather feature.
/// Inherits [Equatable] to allow flutter_bloc to compare previous and current states,
/// triggering UI rebuilds only when the state actually changes.
class WeatherState extends Equatable {
  /// The current state of the weather operation.
  final WeatherStatus status;
  
  /// The weather data object. Nullable since it won't exist in initial or purely error states.
  final WeatherModel? weatherData;
  
  /// A message to display in case of an error or info.
  final String message;
  
  /// Indicates if the displayed data is loaded from local cache due to offline/error conditions.
  final bool isOffline;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weatherData,
    this.message = '',
    this.isOffline = false,
  });

  /// Allows creating a new state by overriding specific fields of the current state.
  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weatherData,
    String? message,
    bool? isOffline,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherData: weatherData ?? this.weatherData,
      message: message ?? this.message,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [status, weatherData, message, isOffline];
}
