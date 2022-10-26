import 'package:social_instagram/modules/posts/repos/create_post_repo.dart';

class CreatePostBloc {
  Future<bool> createPost(String des, List<String> ids) async {
    try {
      final data = {"description": des, "img_upload_ids": ids};
      final response = await CreatePostRepo().postData(data);
      return response;
    } catch (e) {
      return false;
    }
  }
}
