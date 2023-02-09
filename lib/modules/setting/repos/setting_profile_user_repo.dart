import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/providers/api_provider.dart';

class SettingProfileUserRepo {
  final _apiProvider = ApiProvider();

  Future<User> getProfileUser() async {
    try {
      final response = await _apiProvider.get('/profile');
      if (response.statusCode != 200) {
        throw Exception('Failed to load profile');
      }
      return User.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
