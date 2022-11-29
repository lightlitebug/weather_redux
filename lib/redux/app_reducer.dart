import 'app_state.dart';
import 'temp_settings/temp_settings_reducer.dart';
import 'weather/weather_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    weatherState: weatherReducer(state.weatherState, action),
    tempSettingsState: tempSettingsReducer(state.tempSettingsState, action),
  );
}
