import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/profileUser/repos/post_paging_repo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

class ListPostByUserBloc extends PagingDataBehaviorBloc<Post> {
  final PostUserPagingRepo _postsUserPagingRepo;

  Stream<List<Post>?> get postStream => dataStream;

  ListPostByUserBloc(this._postsUserPagingRepo) {
    getPost();
  }

  Future<void> getPost() async {
    return getData();
  }

  @override
  PagingRepo<Post> get dataRepo => _postsUserPagingRepo;
}
