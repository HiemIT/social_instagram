import 'package:social_instagram/providers/api_provider.dart';

class ReadNotificationRepo {
  final String notifyId;

  final _apiProvider = ApiProvider();

  ReadNotificationRepo(this.notifyId);

  Future<bool> readNotification() async {
    try {
      final response = await _apiProvider.put(
        '/notifications/$notifyId',
      );

      return (response.statusCode != 200) ? false : true;
    } catch (e) {
      rethrow;
    }
  }
}
