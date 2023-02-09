import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/repos/profile_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class ProfileByBloc extends BlocBase {
  final _profileByUserCtrl = BehaviorSubject<User?>();
  final ProfileRepo _profileRepo;

  Stream<User> get profileByUserStream =>
      _profileByUserCtrl.stream
          .where((event) => event != null)
          .map((event) => event!);


  ProfileByBloc(this._profileRepo);

  Future<void> getProfileByUser() async {
    try {
      final res = await _profileRepo.getProfileById();
      if (res != null) {
        _profileByUserCtrl.sink.add(res);
      }
    } catch (e) {
      _profileByUserCtrl.sink.addError(e);
      rethrow;
    }
  }


  @override
  void dispose() {
    _profileByUserCtrl.close();
  }
}
