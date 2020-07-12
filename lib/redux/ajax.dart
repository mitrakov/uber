import 'dart:convert';
import 'package:uber/coordinates.dart';
import 'package:http/http.dart';

class Ajax {
  static final baseUrl = "http://mitrakoff.com/30001";

  static Future<Map<String, double>> fetchPrices(Coordinates c1, Coordinates c2) async {
    final response = await post("$baseUrl/tariff", body: c1.toPlain(c2).toJson());
    if (response.statusCode == 200) {
      final Map<String, double> prices = json.decode(response.body);
      return prices;
    } else throw Exception("Failed to fetch prices: ${response.statusCode}: ${response.body}");
  }
}
