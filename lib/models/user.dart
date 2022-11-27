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

  @JsonKey(name: 'avatar')
  final Picture? avatar;

  @JsonKey(name: 'counters')
  final Counters? counters;

  User(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.avatar,
      this.counters});

  String get displayFirstName => firstName ?? '';

  String get displayName => [firstName ?? '', lastName ?? ''].join(' ').trim();

  String get displayUsername => '@${username ?? ""}';

  String get imgUrl {
    return avatar?.cloudUrl() ?? '';
  }

  int get countPhotos {
    return counters?.photos ?? 0;
  }

  int get countLikes {
    return counters?.likes ?? 0;
  }

  int get countCollections {
    return counters?.collections ?? 0;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
