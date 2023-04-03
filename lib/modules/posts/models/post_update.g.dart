// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUpdate _$PostUpdateFromJson(Map<String, dynamic> json) => PostUpdate(
      id: json['id'] as String?,
      categoryId: json['categoryId'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PostUpdateToJson(PostUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('description', instance.description);
  return val;
}
