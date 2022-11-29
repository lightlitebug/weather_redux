import 'package:equatable/equatable.dart';

import 'weather/weather_state.dart';

class AppState extends Equatable {
  final WeatherState weatherState;
  const AppState({
    required this.weatherState,
  });

  factory AppState.initial() {
    return AppState(
      weatherState: WeatherState.initial(),
    );
  }

  @override
  List<Object> get props => [weatherState];

  @override
  String toString() => 'AppState(weatherState: $weatherState)';

  AppState copyWith({
    WeatherState? weatherState,
  }) {
    return AppState(
      weatherState: weatherState ?? this.weatherState,
    );
  }
}
