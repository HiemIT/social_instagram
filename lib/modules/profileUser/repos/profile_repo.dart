import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/providers/api_provider.dart';

class ProfileRepo {
  // ở class Này cần có id của user để lấy thông tin của user đó
  final String? idUser;
  final _apiProvider = ApiProvider();

  ProfileRepo({this.idUser});

  Future<User> getProfile() async {
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

  // TODO: get gắn giá trị từ hàm getProfile rồi gắn cho biến idUser

  Future<User> getProfileById() async {
    try {
      final response = await _apiProvider.get('/users/$idUser');

      if (response.statusCode != 200) {
        throw Exception('Failed to load profile');
      }
      return User.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
