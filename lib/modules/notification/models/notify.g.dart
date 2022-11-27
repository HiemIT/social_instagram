// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) => Notify(
      id: json['id'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      receiverId: json['receiver_id'] as String?,
      pushed: json['pushed'] as int?,
      receiverType: json['receiver_type'] as String?,
      isRead: json['is_read'] as int?,
      userId: json['user_id'] as String?,
      event: json['event'] as String?,
      actorId: json['actor_id'] as String?,
      payload: json['payload'] == null
          ? null
          : Payload.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotifyToJson(Notify instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'event': instance.event,
      'actor_id': instance.actorId,
      'receiver_id': instance.receiverId,
      'receiver_type': instance.receiverType,
      'is_read': instance.isRead,
      'pushed': instance.pushed,
      'payload': instance.payload,
    };
