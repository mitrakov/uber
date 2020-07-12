import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:uber/coordinates.dart';
import 'package:uber/redux/actions.dart';
import 'package:uber/redux/ajax.dart';
import 'package:uber/redux/appstate.dart';

class Thunk {
  static ThunkAction<AppState> fetchPrices(Coordinates c1, Coordinates c2) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(PricesFetchedAction(await Ajax.fetchPrices(c1, c2)));
      } catch(e) {
        store.dispatch(FetchErrorAction(e.toString()));
      }
    };
  }
}
