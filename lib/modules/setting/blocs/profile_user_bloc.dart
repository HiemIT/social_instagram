import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/blocs/app_state_bloc.dart';
import 'package:social_instagram/models/user.dart';

import '../../../providers/bloc_provider.dart';
import '../repos/setting_profile_user_repo.dart';

class ProfileUserBloc extends BlocBase {
  final _profileUserFetcher = BehaviorSubject<User>();
  final SettingProfileUserRepo _settingProfileUserRepo =
      SettingProfileUserRepo();

  Stream<User?> get profileUser => _profileUserFetcher.stream;

  ProfileUserBloc() {
    fetchProfileUser();
  }

  fetchProfileUser() async {
    await AppStateBloc.getProfileUser().then((user) {
      print('fetchProfileUser: ${user.toJson()}');
      _profileUserFetcher.sink.add(user);
      print('fetchProfileUser: ${user.toJson()}');
    }).catchError((e) {
      _profileUserFetcher.sink.addError(e);
    });
  }

  getProfileUser() async {
    await _settingProfileUserRepo.getProfileUser().then((user) {
      _profileUserFetcher.sink.add(user);
    }).catchError((e) {
      _profileUserFetcher.sink.addError(e);
    });
  }

  // Create function to get Profile User

  // TODO Tạo hàm để lấy list post của user

  dispose() {
    _profileUserFetcher.close();
  }
}
