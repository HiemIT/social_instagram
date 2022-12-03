import 'package:social_instagram/providers/api_provider.dart';
import 'package:social_instagram/providers/log_provider.dart';
import 'package:social_instagram/utils/model_type.dart';

abstract class CanLikeRepo {
  // true
  Future<bool> like(String id);

  // false
  Future<bool> unlike(String id);
}

class LikeRepo implements CanLikeRepo {
  final _apiProvider = ApiProvider();

  final String likeUrl;
  final String unlikeUrl;

  LogProvider get logger => const LogProvider('⚡️ LikeRepo');

  LikeRepo._internal(this.likeUrl, this.unlikeUrl);

  factory LikeRepo(ModelType type) {
    switch (type) {
      case ModelType.post:
        return LikeRepo._internal("/posts/:id/like", "/posts/:id/unlike");
      default:
        return LikeRepo._internal("/posts/:id/like", "/posts/:id/unlike");
    }
  }

  @override
  Future<bool> like(String id) async {
    final url = likeUrl.replaceFirst(":id", id);
    try {
      final res = await _apiProvider.post(url);
      logger.log('Calling api $url');
      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unlike(String id) async {
    final url = unlikeUrl.replaceFirst(":id", id);
    try {
      final res = await _apiProvider.post(url);
      logger.log('Calling api $url');

      return res.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
