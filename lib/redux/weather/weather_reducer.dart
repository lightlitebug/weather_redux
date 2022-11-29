import 'package:redux/redux.dart';

import 'weather_action.dart';
import 'weather_state.dart';

WeatherState fetchWeatherReducer(
  WeatherState state,
  FetchWeatherAction action,
) {
  return state.copyWith(weatherStatus: WeatherStatus.loading);
}

WeatherState fetchWeatherSucceededReducer(
  WeatherState state,
  FetchWeatherSucceededAction action,
) {
  return state.copyWith(
    weatherStatus: WeatherStatus.success,
    weather: action.weather,
  );
}

WeatherState fetchWeatherFailedReducer(
  WeatherState state,
  FetchWeatherFailedAction action,
) {
  return state.copyWith(
    weatherStatus: WeatherStatus.failure,
    error: action.error,
  );
}

Reducer<WeatherState> weatherReducer = combineReducers<WeatherState>([
  TypedReducer<WeatherState, FetchWeatherAction>(fetchWeatherReducer),
  TypedReducer<WeatherState, FetchWeatherSucceededAction>(
    fetchWeatherSucceededReducer,
  ),
  TypedReducer<WeatherState, FetchWeatherFailedAction>(
    fetchWeatherFailedReducer,
  ),
]);
