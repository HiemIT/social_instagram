// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String?,
      items: json['items'] as String?,
      accessory: json['accessory'] == null
          ? null
          : Accessory.fromJson(json['accessory'] as Map<String, dynamic>),
      pushNamed: json['push_named'] as String?,
      pushId: json['push_id'] as String?,
      isSingle: json['is_single'] as bool?,
    );

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'user': instance.user,
      'title': instance.title,
      'items': instance.items,
      'accessory': instance.accessory,
      'push_named': instance.pushNamed,
      'push_id': instance.pushId,
      'is_single': instance.isSingle,
    };
