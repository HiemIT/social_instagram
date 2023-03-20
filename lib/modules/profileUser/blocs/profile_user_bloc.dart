import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profileUser/repos/profile_repo.dart';
import 'package:social_instagram/modules/profileUser/blocs/detail_user_bloc.dart';
import 'package:social_instagram/modules/profileUser/blocs/list_post_by_user_bloc.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

import '../repos/post_paging_repo.dart';

class ProfileUserBloc extends BlocBase {
  final String uid;
  final DetailUserBloc _detailUserBloc;
  final ListPostByUserBloc _listPostByUserBloc;
  Stream<User?> get detailUserStream => _detailUserBloc.detailUserStream;

  ProfileUserBloc(this.uid)
      : _detailUserBloc = DetailUserBloc(ProfileRepo(idUser: uid)),
        _listPostByUserBloc = ListPostByUserBloc(PostUserPagingRepo(uid: uid));

  @override
  void dispose() {}
}
