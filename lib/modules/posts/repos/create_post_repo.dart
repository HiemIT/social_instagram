import '../../../providers/api_provider.dart';

class CreatePostRepo {
  final _apiProvider = ApiProvider();

  Future<bool> postData(dynamic data) async {
    try {
      final response = await _apiProvider.post('/posts', data: data);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
