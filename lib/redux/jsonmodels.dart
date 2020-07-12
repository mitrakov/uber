import 'package:json_annotation/json_annotation.dart';
part 'jsonmodels.g.dart';

@JsonSerializable()
class PlainCoordinates {
  final double lat1;
  final double lon1;
  final double lat2;
  final double lon2;

  PlainCoordinates(this.lat1, this.lon1, this.lat2, this.lon2);

  Map<String, dynamic> toJson() => _$PlainCoordinatesToJson(this);
}
