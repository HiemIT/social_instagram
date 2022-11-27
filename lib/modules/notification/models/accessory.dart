import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/modules/notification/models/thumbnail.dart';

part 'accessory.g.dart';

@JsonSerializable()
class Accessory {
  @JsonKey(name: 'model')
  final String? model;

  @JsonKey(name: 'model_id')
  final String? modelId;

  @JsonKey(name: 'thumbnail')
  final Thumbnail? thumbnail;

  @JsonKey(name: 'is_single')
  final bool isSingle;

  Accessory({this.model, this.modelId, this.thumbnail, this.isSingle = true});

  factory Accessory.fromJson(Map<String, dynamic> json) =>
      _$AccessoryFromJson(json);

  Map<String, dynamic> toJson() => _$AccessoryToJson(this);
}
