import 'package:equatable/equatable.dart';

import 'temp_settings/temp_settings_state.dart';
import 'weather/weather_state.dart';

class AppState extends Equatable {
  final WeatherState weatherState;
  final TempSettingsState tempSettingsState;
  const AppState({
    required this.weatherState,
    required this.tempSettingsState,
  });

  factory AppState.initial() {
    return AppState(
      weatherState: WeatherState.initial(),
      tempSettingsState: TempSettingsState.initial(),
    );
  }

  @override
  List<Object> get props => [weatherState, tempSettingsState];

  @override
  String toString() =>
      'AppState(weatherState: $weatherState, tempSettingsState: $tempSettingsState)';

  AppState copyWith({
    WeatherState? weatherState,
    TempSettingsState? tempSettingsState,
  }) {
    return AppState(
      weatherState: weatherState ?? this.weatherState,
      tempSettingsState: tempSettingsState ?? this.tempSettingsState,
    );
  }
}
