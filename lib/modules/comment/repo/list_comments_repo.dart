import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/providers/api_provider.dart';

class ListCommentsRepo {
  final apiProvider = ApiProvider();
  final String postId;

  ListCommentsRepo(this.postId);

  Future<List<Comment>?> getComments() async {
    try {
      final response = await apiProvider.get(
        '/posts/$postId/comments',
      );
      if (response.statusCode != 200) {
        return null;
      }
      List data = response.data['data'];

      return data.map((e) => Comment.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
