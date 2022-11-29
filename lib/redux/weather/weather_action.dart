import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';
import '../../repositories/weather_repository.dart';
import '../app_state.dart';

class FetchWeatherAction {
  @override
  String toString() => 'FetchWeatherAction()';
}

class FetchWeatherSucceededAction {
  final Weather weather;
  FetchWeatherSucceededAction({
    required this.weather,
  });

  @override
  String toString() => 'FetchWeatherSucceededAction(weather: $weather)';
}

class FetchWeatherFailedAction {
  final CustomError error;
  FetchWeatherFailedAction({
    required this.error,
  });

  @override
  String toString() => 'FetchWeatherFailedAction(error: $error)';
}

ThunkAction<AppState> fetchWeatherAndDispatch(String city) {
  return (Store<AppState> store) async {
    store.dispatch(FetchWeatherAction());

    try {
      final Weather weather =
          await WeatherRepository.instance.fetchWeather(city);
      store.dispatch(FetchWeatherSucceededAction(weather: weather));
    } on CustomError catch (error) {
      store.dispatch(FetchWeatherFailedAction(error: error));
    }
  };
}
