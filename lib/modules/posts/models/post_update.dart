import 'package:json_annotation/json_annotation.dart';

part 'post_update.g.dart';

@JsonSerializable()
class PostUpdate {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'categoryId', includeIfNull: false)
  final String? categoryId;

  @JsonKey(name: 'description', includeIfNull: false)
  String? description;

  PostUpdate({this.id, this.categoryId, this.description});

  Map<String, dynamic> toJson() => _$PostUpdateToJson(this);
}
