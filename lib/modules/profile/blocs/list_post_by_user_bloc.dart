import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/profile/repos/post_paging_repo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

class ListPostByUserBloc extends PagingDataBehaviorBloc<Post> {
  Stream<List<Post>?> get postStream => dataStream;
  final String idUser;
  final PostUserPagingRepo _repo;

  ListPostByUserBloc({required this.idUser})
      : _repo = PostUserPagingRepo(idUser: idUser) {
    getPost();
  }

  Future<void> getPost() async {
    return getData();
  }

  @override
  void dispose() {}

  @override
  PagingRepo<Post> get dataRepo => _repo;
}
