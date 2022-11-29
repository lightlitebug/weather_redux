import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../redux/temp_settings/temp_settings_action.dart';
import '../redux/temp_settings/temp_settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: const Text('Temperature Unit'),
          subtitle: const Text('Celsius/Fahrenheit (Default: Celsius)'),
          trailing: StoreConnector<AppState, _ViewModel>(
            distinct: true,
            converter: (Store<AppState> store) => _ViewModel.fromStore(store),
            builder: (BuildContext context, _ViewModel vm) {
              return Switch(
                value: vm.currentTempUnit == TempUnit.celsius,
                onChanged: (_) {
                  vm.toggleTempUnit();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final TempUnit currentTempUnit;
  final void Function() toggleTempUnit;
  const _ViewModel({
    required this.currentTempUnit,
    required this.toggleTempUnit,
  });

  @override
  List<Object> get props => [currentTempUnit];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      currentTempUnit: store.state.tempSettingsState.tempUnit,
      toggleTempUnit: () => store.dispatch(ToggleTempUnitAction()),
    );
  }
}
