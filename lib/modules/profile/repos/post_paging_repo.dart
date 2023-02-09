import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/resource/paging_repo.dart';

class PostUserPagingRepo with PagingRepo<Post> {
  final String idUser;

  PostUserPagingRepo({required this.idUser});

  @override
  Post parseJSON(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  String get url {
    return '/users/$idUser/posts';
  }
}
