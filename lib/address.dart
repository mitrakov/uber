class Address {
  final String addr;
  final String city;
  final String country;

  Address(this.addr, this.city, this.country);
  factory Address.predict(String s) => Address(s, "", "");
  factory Address.fromStorageString(String s) {
    final tokens =  s.split("|");
    return Address(tokens[0], tokens[1], tokens[2]);
  }

  String toShortString() => '$addr';

  String toStorageString() => '$addr|$city|$country';

  @override
  String toString() => '$addr, $city, $country';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          addr == other.addr &&
          city == other.city &&
          country == other.country;

  @override
  int get hashCode => addr.hashCode ^ city.hashCode ^ country.hashCode;
}
