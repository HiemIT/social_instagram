import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profileUser/blocs/detail_user_bloc.dart';
import 'package:social_instagram/modules/profileUser/blocs/list_photos_by_user_bloc.dart';
import 'package:social_instagram/modules/profileUser/repos/profile_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

import '../../posts/models/photo.dart';
import '../../posts/models/post.dart';
import '../repos/photos_paging_repo.dart';
import '../repos/post_paging_repo.dart';
import 'list_post_by_user_bloc.dart';

class ProfileUserBloc extends BlocBase {
  final String uid;
  final DetailUserBloc _detailUserBloc;
  final ListPhotoByUserBloc _listPhotosByUserBloc;
  final ListPostByUserBloc _listPostByUserBloc;
  Stream<User?> get detailUserStream => _detailUserBloc.detailUserStream;
  Stream<List<Photo>?> get photosStream => _listPhotosByUserBloc.postStream;
  Stream<List<Post>?> get postStream => _listPostByUserBloc.postStream;

  ProfileUserBloc(this.uid)
      : _detailUserBloc = DetailUserBloc(ProfileRepo(idUser: uid)),
        _listPhotosByUserBloc =
            ListPhotoByUserBloc(PhotosUserPagingRepo(uid: uid)),
        _listPostByUserBloc = ListPostByUserBloc(PostUserPagingRepo(uid: uid));

  Future<void> getPhotos() async {
    return _listPhotosByUserBloc.getPhotos();
  }

  // getPosts
  Future<void> getPosts() async {
    return _listPostByUserBloc.getPost();
  }

  @override
  void dispose() {}
}
