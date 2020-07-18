class PricesFetchedAction {
  final Map<String, int> prices;
  PricesFetchedAction(this.prices);
}

class FetchErrorAction {
  final String error;
  FetchErrorAction(this.error);
}
