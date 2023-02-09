import 'package:social_instagram/providers/api_provider.dart';

class UpdateProfileRepo {
  final _apiProvider = ApiProvider();

  Future<bool> updateProfile(dynamic data) async {
    try {
      final response = await _apiProvider.put('/profile', data: data);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
