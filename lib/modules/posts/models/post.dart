import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/modules/posts/models/picture.dart';

class Post {
  String? id;
  int? status;
  String? createdAt;
  // String? updatedAt;
  // String? title;
  String? description;
  // int? commentCounts;
  List<Picture>? images;
  // int? likeCounts;
  // int? viewCounts;
  // int? pulseScore;
  // bool? isSensitive;
  // bool? isPrivate;
  // User? user;
  List<Photo>? photos;
  // bool? liked;

  Post({
    this.id,
    this.status,
    this.createdAt,
    // this.updatedAt,
    // this.title,
    this.description,
    // this.commentCounts,
    this.images,
    // this.likeCounts,
    // this.viewCounts,
    // this.pulseScore,
    // this.isSensitive,
    // this.isPrivate,
    // this.user,
    this.photos,
    // this.liked
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // title = json['title'];
    description = json['description'];
    // commentCounts = json['comment_counts'];
    if (json['images'] != null) {
      images = <Picture>[];
      json['images'].forEach((v) {
        images!.add(new Picture.fromJson(v));
      });
    }
    // likeCounts = json['like_counts'];
    // viewCounts = json['view_counts'];
    // pulseScore = json['pulse_score'];
    // isSensitive = json['is_sensitive'];
    // isPrivate = json['is_private'];
    // user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['photos'] != null) {
      photos = <Photo>[];
      json['photos'].forEach((v) {
        photos!.add(new Photo.fromJson(v));
      });
    }
    // liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    // data['title'] = this.title;
    data['description'] = this.description;
    // data['comment_counts'] = this.commentCounts;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    // data['like_counts'] = this.likeCounts;
    // data['view_counts'] = this.viewCounts;
    // data['pulse_score'] = this.pulseScore;
    // data['is_sensitive'] = this.isSensitive;
    // data['is_private'] = this.isPrivate;
    // if (this.user != null) {
    //   data['user'] = this.user!.toJson();
    // }
    // if (this.photos != null) {
    //   data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    // }
    // data['liked'] = this.liked;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  Avatar? avatar;
  String? systemRole;
  bool? isVerified;
  String? createdAt;

  User(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.avatar,
      this.systemRole,
      this.isVerified,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar =
        json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    systemRole = json['system_role'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.avatar != null) {
      data['avatar'] = this.avatar!.toJson();
    }
    data['system_role'] = this.systemRole;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    return data;
  }
}

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
