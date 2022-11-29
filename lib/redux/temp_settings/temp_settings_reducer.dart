import 'package:redux/redux.dart';

import 'temp_settings_action.dart';
import 'temp_settings_state.dart';

TempSettingsState toggleTempUnitReducer(
  TempSettingsState state,
  ToggleTempUnitAction action,
) {
  return state.copyWith(
    tempUnit: state.tempUnit == TempUnit.celsius
        ? TempUnit.fahrenheit
        : TempUnit.celsius,
  );
}

Reducer<TempSettingsState> tempSettingsReducer =
    combineReducers<TempSettingsState>([
  TypedReducer<TempSettingsState, ToggleTempUnitAction>(
    toggleTempUnitReducer,
  ),
]);
