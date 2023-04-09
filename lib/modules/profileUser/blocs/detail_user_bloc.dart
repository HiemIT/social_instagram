import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profileUser/repos/profile_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

enum StateDetailUser { loading, loaded, error }

class DetailUserBloc extends BlocBase {
  final ProfileRepo _profileRepo;

  final _detailUserCtrl = BehaviorSubject<User?>();

  Stream<User?> get detailUserStream => _detailUserCtrl.stream;

  DetailUserBloc(this._profileRepo) {
    getDetailUser();
  }

  Future<StateDetailUser> getDetailUser() async {
    try {
      final user = await _profileRepo.getProfileById();
      _detailUserCtrl.add(user);
      return StateDetailUser.loaded;
    } catch (e) {
      return StateDetailUser.error;
    }
  }

  @override
  void dispose() {
    _detailUserCtrl.close();
  }
}
