// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accessory _$AccessoryFromJson(Map<String, dynamic> json) => Accessory(
      model: json['model'] as String?,
      modelId: json['model_id'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      isSingle: json['is_single'] as bool? ?? true,
    );

Map<String, dynamic> _$AccessoryToJson(Accessory instance) => <String, dynamic>{
      'model': instance.model,
      'model_id': instance.modelId,
      'thumbnail': instance.thumbnail,
      'is_single': instance.isSingle,
    };
