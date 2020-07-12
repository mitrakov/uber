class PricesFetchedAction {
  final Map<String, double> prices;
  PricesFetchedAction(this.prices);
}

class FetchErrorAction {
  final String error;
  FetchErrorAction(this.error);
}
