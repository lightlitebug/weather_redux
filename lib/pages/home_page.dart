import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/custom_error.dart';
import '../models/weather.dart';
import '../redux/app_state.dart';
import '../redux/weather/weather_action.dart';
import '../redux/weather/weather_state.dart';
import '../widgets/error_dialog.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      onWillChange: (_ViewModel? prev, _ViewModel vm) {
        if (vm.weatherStatus == WeatherStatus.failure) {
          errorDialog(context, vm.error);
        }
      },
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  _city = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const SearchPage();
                    }),
                  );
                  if (_city != null) {
                    vm.fetchWeather(_city!);
                  }
                },
              ),
            ],
          ),
          body: const Center(
            child: Text('Home'),
          ),
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final void Function(String city) fetchWeather;
  final Weather weather;
  final WeatherStatus weatherStatus;
  final CustomError error;
  const _ViewModel({
    required this.fetchWeather,
    required this.weather,
    required this.weatherStatus,
    required this.error,
  });

  @override
  List<Object> get props {
    return [weather, weatherStatus, error];
  }

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      weather: store.state.weatherState.weather,
      weatherStatus: store.state.weatherState.weatherStatus,
      error: store.state.weatherState.error,
      fetchWeather: (String city) =>
          store.dispatch(fetchWeatherAndDispatch(city)),
    );
  }
}
