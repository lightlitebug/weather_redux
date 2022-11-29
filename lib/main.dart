import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:weather_redux/constants/constants.dart';

import 'package:weather_redux/redux/app_middleware.dart';

import 'pages/home_page.dart';
import 'redux/app_reducer.dart';
import 'redux/app_state.dart';

late final Store<AppState> store;

void main() async {
  await dotenv.load(fileName: '.env');
  store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: appMiddleware(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (BuildContext context, _ViewModel vm) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            theme: vm.currentTemp > kWarmOrNot
                ? ThemeData.light()
                : ThemeData.dark(),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final double currentTemp;
  const _ViewModel({
    required this.currentTemp,
  });

  @override
  List<Object> get props => [currentTemp];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      currentTemp: store.state.weatherState.weather.temp,
    );
  }
}
