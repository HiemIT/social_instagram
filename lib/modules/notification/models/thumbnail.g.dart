// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      imgId: json['img_id'] as int?,
      url: json['url'] as String?,
      orgUrl: json['org_url'] as String?,
      orgWidth: json['org_width'] as int?,
      orgHeight: json['org_height'] as int?,
      cloudName: json['cloud_name'] as String?,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('img_id', instance.imgId);
  writeNotNull('url', instance.url);
  writeNotNull('org_width', instance.orgWidth);
  writeNotNull('org_height', instance.orgHeight);
  writeNotNull('org_url', instance.orgUrl);
  writeNotNull('cloud_name', instance.cloudName);
  return val;
}
