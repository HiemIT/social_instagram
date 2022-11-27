import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/notification/models/accessory.dart';

part 'payload.g.dart';

@JsonSerializable()
class Payload {
  @JsonKey(name: 'user')
  final User? user;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'items')
  final String? items;

  @JsonKey(name: 'accessory')
  final Accessory? accessory;

  @JsonKey(name: 'push_named')
  final String? pushNamed;

  @JsonKey(name: 'push_id')
  final String? pushId;

  @JsonKey(name: 'is_single')
  final bool? isSingle;

  Payload(
      {this.user,
      this.title,
      this.items,
      this.accessory,
      this.pushNamed,
      this.pushId,
      this.isSingle});

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
