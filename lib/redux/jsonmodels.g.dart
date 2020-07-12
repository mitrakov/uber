// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonmodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlainCoordinates _$PlainCoordinatesFromJson(Map<String, dynamic> json) {
  return PlainCoordinates(
    (json['lat1'] as num)?.toDouble(),
    (json['lon1'] as num)?.toDouble(),
    (json['lat2'] as num)?.toDouble(),
    (json['lon2'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PlainCoordinatesToJson(PlainCoordinates instance) =>
    <String, dynamic>{
      'lat1': instance.lat1,
      'lon1': instance.lon1,
      'lat2': instance.lat2,
      'lon2': instance.lon2,
    };
