import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/modules/posts/models/picture.dart';

import '../../../models/user.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;

  @JsonKey(name: 'status', includeIfNull: false)
  final int? status;

  @JsonKey(name: 'created_at', includeIfNull: false)
  final DateTime? createdAt;

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;

  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;

  @JsonKey(name: 'images', includeIfNull: false)
  final List<Picture>? images;

  @JsonKey(name: 'photos', includeIfNull: false)
  final List<Photo>? photos;

  @JsonKey(name: 'comment_counts', includeIfNull: false)
  final int? commentCounts;

  @JsonKey(name: 'like_counts', includeIfNull: false)
  int? likeCounts;

  @JsonKey(name: 'liked', includeIfNull: false)
  bool? liked;

  @JsonKey(name: 'user', includeIfNull: false)
  final User? user;

  Post({
    this.id,
    this.status,
    this.createdAt,
    this.title,
    this.description,
    this.images,
    this.photos,
    this.commentCounts,
    this.likeCounts,
    this.liked,
    this.user,
  });

  String? get urlUserAvatar => user?.imgUrl;

  String get displayName => user?.displayName ?? '';

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

// class User {
//   String? id;
//   String? username;
//   String? firstName;
//   String? lastName;
//   Avatar? avatar;
//   String? systemRole;
//   bool? isVerified;
//   String? createdAt;
//
//   User(
//       {this.id,
//       this.username,
//       this.firstName,
//       this.lastName,
//       this.avatar,
//       this.systemRole,
//       this.isVerified,
//       this.createdAt});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     avatar =
//         json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
//     systemRole = json['system_role'];
//     isVerified = json['is_verified'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     if (this.avatar != null) {
//       data['avatar'] = this.avatar!.toJson();
//     }
//     data['system_role'] = this.systemRole;
//     data['is_verified'] = this.isVerified;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }

class Avatar {
  String? url;
  int? orgWidth;
  int? orgHeight;
  String? orgUrl;
  String? cloudName;
  String? dominantColor;

  Avatar(
      {this.url,
      this.orgWidth,
      this.orgHeight,
      this.orgUrl,
      this.cloudName,
      this.dominantColor});

  Avatar.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    orgWidth = json['org_width'];
    orgHeight = json['org_height'];
    orgUrl = json['org_url'];
    cloudName = json['cloud_name'];
    dominantColor = json['dominant_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['org_width'] = this.orgWidth;
    data['org_height'] = this.orgHeight;
    data['org_url'] = this.orgUrl;
    data['cloud_name'] = this.cloudName;
    data['dominant_color'] = this.dominantColor;
    return data;
  }
}
