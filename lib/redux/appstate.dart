import 'package:flutter/foundation.dart';

class AppState {
  final Map<String, int> prices;
  final String lastError;

  AppState(this.prices, this.lastError) {
    if (lastError.isNotEmpty)
      print("ERROR: $lastError");
  }

  @override
  String toString() => 'AppState{prices: $prices, lastError: $lastError}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && runtimeType == other.runtimeType && mapEquals(prices, other.prices) && lastError == other.lastError;

  @override
  int get hashCode => prices.hashCode ^ lastError.hashCode;
}
