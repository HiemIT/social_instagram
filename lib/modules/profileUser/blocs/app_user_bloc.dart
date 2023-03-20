import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/modules/profileUser/repos/profile_repo.dart';
import 'package:social_instagram/modules/profileUser/repos/update_profile_repo.dart';

class AppUserBloc extends BlocBase {
  final ProfileRepo _profileRepo = ProfileRepo();
  final UpdateProfileRepo _updateProfileRepo = UpdateProfileRepo();
  final BehaviorSubject<User?> _userController = BehaviorSubject<User?>();

  Stream<User?> get userStream => _userController.stream;

  AppUserBloc() {
    getUser();
  }

  Future<void> getUser() async {
    try {
      final user = await _profileRepo.getProfile();
      _userController.add(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(User? user) async {
    try {
      await _updateProfileRepo.updateProfile(user);
      _userController.add(user);
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    _userController.close();
  }
}
