import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/modules/notification/models/payload.dart';

part 'notify.g.dart';

@JsonSerializable()
class Notify {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'event')
  final String? event;

  @JsonKey(name: 'actor_id')
  final String? actorId;

  @JsonKey(name: 'receiver_id')
  final String? receiverId;

  @JsonKey(name: 'receiver_type')
  final String? receiverType;

  @JsonKey(name: 'is_read')
  int? isRead;

  @JsonKey(name: 'pushed')
  final int? pushed;

  @JsonKey(name: 'payload')
  final Payload? payload;

  Notify({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.receiverId,
    this.pushed,
    this.receiverType,
    this.isRead,
    this.userId,
    this.event,
    this.actorId,
    this.payload,
  });

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);

  String get postId => payload!.accessory!.modelId ?? "";
  String get uId => payload!.user!.id ?? "";

  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}
