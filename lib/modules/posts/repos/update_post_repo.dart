import 'package:social_instagram/resource/update_repo.dart';

class UpdatePostRepo extends UpdateRepo {
  final String postId;

  UpdatePostRepo(this.postId);

  @override
  String get url => '/posts/$postId';
}
