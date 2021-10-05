import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/domain/entities/region.dart';
part 'get_regions_response.g.dart';

@JsonSerializable()
class RegionItem implements Region {
  RegionItem({this.distance, this.locationType, this.title, this.woeid});
  factory RegionItem.fromJson(Map<String, dynamic> json) =>
      _$RegionItemFromJson(json);
  @override
  double? distance;
  @JsonKey(name: 'location_type')
  @override
  String? locationType;

  @override
  String? title;

  @override
  int? woeid;
}
