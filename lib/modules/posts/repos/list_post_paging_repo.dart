import 'package:social_instagram/modules/posts/models/post.dart';

import '../../../resource/paging_repo.dart';

class ListPostPagingRepo with PagingRepo<Post> {
  @override
  Post parseJSON(Map<String, dynamic> json) {
    return Post.fromJson(json);
  }

  @override
  String get url => '/posts';
}
