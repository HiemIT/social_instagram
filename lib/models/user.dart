import 'package:json_annotation/json_annotation.dart';
import 'package:social_instagram/models/counters.dart';
import 'package:social_instagram/modules/posts/models/picture.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'username')
  final String? username;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'avatar')
  final Picture? avatar;

  @JsonKey(name: 'counters')
  final Counters? counters;

  @JsonKey(name: 'followed')
  final bool? followed;

  @JsonKey(name: 'instagram_username')
  final String? instagramUsername;

  User({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.counters,
    this.instagramUsername,
    this.followed,
  });

  String get displayFirstName => firstName ?? '';

  String get displayName => [firstName ?? '', lastName ?? ''].join(' ').trim();

  String get displayUsername => '@${username ?? ""}';

  String get imgUrl {
    return avatar?.cloudUrl() ?? '';
  }

  String get displayInstagramUsername {
    return instagramUsername ?? '';
  }

  int get totalPhotos {
    return counters?.photos ?? 0;
  }

  int get totalFollowers {
    return counters?.followers ?? 0;
  }

  int get totalFollowings {
    return counters?.followings ?? 0;
  }

  int get totalLikes {
    return counters?.likes ?? 0;
  }

  int get totalCollections {
    return counters?.collections ?? 0;
  }

  bool get followedUser {
    return followed ?? false;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, username: $username, firstName: $firstName, lastName: $lastName, email: $email, avatar: $avatar, counters: $counters}';
  }
}
