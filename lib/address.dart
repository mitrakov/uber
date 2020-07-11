class Address {
  final String addr;
  final String city;
  final String country;

  Address(this.addr, this.city, this.country);
  Address.predict(this.addr) : this.city = "", this.country = "";

  String toShortString() => '$addr';

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
