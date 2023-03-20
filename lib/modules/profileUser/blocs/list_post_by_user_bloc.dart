import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/resource/paging_repo.dart';

import '../repos/post_paging_repo.dart';

class ListPostByUserBloc extends PagingDataBehaviorBloc<Post> {
  final PostUserPagingRepo _postUserPagingRepo;

  Stream<List<Post>?> get postStream => dataStream;

  ListPostByUserBloc(this._postUserPagingRepo);

  Future<void> getPost() async {
    return getData();
  }

  @override
  void dispose() {}

  @override
  PagingRepo<Post> get dataRepo => _postUserPagingRepo;
}
