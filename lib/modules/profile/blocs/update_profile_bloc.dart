/*
* TODO: Update Profile Bloc
*  - Khởi tạo class UpdateProfileBloc extends BlocBase
*  - Quản lý các sự kiện của UpdateProfileBloc
* */

import 'package:social_instagram/modules/profile/repos/update_profile_repo.dart';

class UpdateProfileBloc {
  Future<bool> updateProfile(
      {String? firstName, String? lastName, String? email}) async {
    try {
      final data = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email
      };
      final response = await UpdateProfileRepo().updateProfile(data);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
