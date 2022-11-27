import 'package:json_annotation/json_annotation.dart';

part 'counters.g.dart';

@JsonSerializable()
class Counters {
  @JsonKey(name: 'photos')
  final int? photos;

  @JsonKey(name: 'likes')
  final int? likes;

  @JsonKey(name: 'collections')
  final int? collections;

  Counters({this.photos, this.likes, this.collections});

  factory Counters.fromJson(Map<String, dynamic> json) =>
      _$CountersFromJson(json);

  Map<String, dynamic> toJson() => _$CountersToJson(this);
}
