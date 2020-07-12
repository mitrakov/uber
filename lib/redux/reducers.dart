import 'package:redux/redux.dart';
import 'package:uber/redux/actions.dart';
import 'package:uber/redux/appstate.dart';

class AppReducer {
  static AppState pricesReducer(AppState state, PricesFetchedAction action) => AppState(action.prices, "");
  static AppState errorReducer(AppState state, FetchErrorAction action) => AppState({}, action.error);

  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, PricesFetchedAction>(pricesReducer),
    TypedReducer<AppState, FetchErrorAction>(errorReducer),
  ]);
}
