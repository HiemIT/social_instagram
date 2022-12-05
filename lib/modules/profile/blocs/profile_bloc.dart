import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/repos/profile_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class ProfileBloc extends BlocBase {
  // behavior subject is a stream controller
  final _profileCtrl = BehaviorSubject<User?>();

  //  khai báo stream để lắng nghe dữ liệu
  Stream<User?> get profileStream => _profileCtrl.stream;

  Future<User> getProfile() async {
    try {
      final res = await ProfileRepo().getProfile();
      _profileCtrl.sink.add(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _profileCtrl.close();
  }
}
