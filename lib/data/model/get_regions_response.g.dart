// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_regions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegionItem _$RegionItemFromJson(Map<String, dynamic> json) => RegionItem(
      distance: (json['distance'] as num?)?.toDouble(),
      locationType: json['location_type'] as String?,
      title: json['title'] as String?,
      woeid: json['woeid'] as int?,
    );

Map<String, dynamic> _$RegionItemToJson(RegionItem instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'location_type': instance.locationType,
      'title': instance.title,
      'woeid': instance.woeid,
    };
