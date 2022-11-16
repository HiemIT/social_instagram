import 'package:flutter/cupertino.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/providers/api_provider.dart';

class PostDetailRepo {
  final apiProvider = ApiProvider();

  Future<Post?> getPostDetail(String postId) async {
    try {
      final response = await apiProvider.get('/posts/$postId');

      if (response.statusCode != 200) {
        return null;
      }
      Map<String, dynamic> data = response.data['data'];
      return Post.fromJson(data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
