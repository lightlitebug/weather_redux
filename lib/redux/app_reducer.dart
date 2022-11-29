import 'app_state.dart';
import 'weather/weather_reducer.dart';

AppState reducer(AppState state, dynamic action) {
  return AppState(
    weatherState: weatherReducer(state.weatherState, action),
  );
}
