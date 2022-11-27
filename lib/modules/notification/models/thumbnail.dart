import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/utils/photo_utils.dart';

part 'thumbnail.g.dart';

@JsonSerializable()
class Thumbnail {
  @JsonKey(name: 'img_id', includeIfNull: false)
  final int? imgId;

  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;

  @JsonKey(name: 'org_width', includeIfNull: false)
  final int? orgWidth;

  @JsonKey(name: 'org_height', includeIfNull: false)
  final int? orgHeight;

  @JsonKey(name: 'org_url', includeIfNull: false)
  final String? orgUrl;

  @JsonKey(name: 'cloud_name', includeIfNull: false)
  final String? cloudName;

  String cloudUrl([int w = 100, int h = 100]) {
    final userAvtUrl = url ?? '';
    if (userAvtUrl.startsWith('https://dofhunt.imgix.net')) {
      return PhotoUtils.genImgIx(userAvtUrl, w, h, focusFace: true);
    }

    if (userAvtUrl.startsWith('https://graph.facebook.com')) {
      return PhotoUtils.genFbImg(userAvtUrl, 100, 100);
    }

    return userAvtUrl;
  }

  Thumbnail({
    this.imgId,
    this.url,
    this.orgUrl,
    this.orgWidth,
    this.orgHeight,
    this.cloudName,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
