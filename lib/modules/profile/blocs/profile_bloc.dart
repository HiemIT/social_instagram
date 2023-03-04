import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/profile/blocs/list_post_by_user_bloc.dart';
import 'package:social_instagram/modules/profile/blocs/profile_by_user_bloc.dart';
import 'package:social_instagram/modules/profile/repos/profile_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class ProfileBloc extends BlocBase {
  final String idUser;
  final ProfileByBloc _profileByBloc;
  final ListPostByUserBloc _listPostByUser;

  Stream<List<Post>?> get postStream => _listPostByUser.postStream;

  Stream<User?> get profileByUserStream => _profileByBloc.profileByUserStream;

  ProfileBloc(this.idUser)
      : _listPostByUser = ListPostByUserBloc(idUser: idUser),
        _profileByBloc = ProfileByBloc(ProfileRepo(idUser: idUser));

  Future<void> getProfileByUser() async => _profileByBloc.getProfileByUser();

  Future<void> getPostByUser() async => _listPostByUser.getData();

  @override
  void dispose() {
    _listPostByUser.dispose();
    _profileByBloc.dispose();
  }
}
