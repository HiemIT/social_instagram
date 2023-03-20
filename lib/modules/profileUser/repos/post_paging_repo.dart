import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/resource/paging_repo.dart';

class PostUserPagingRepo with PagingRepo<Post> {
  final String uid;

  PostUserPagingRepo({required this.uid});

  @override
  Post parseJSON(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  String get url {
    return '/users/$uid}/posts';
  }
}
