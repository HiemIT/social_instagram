import 'package:social_instagram/modules/posts/models/post_update.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

import '../repos/update_post_repo.dart';

class UpdatePostBloc extends BlocBase {
  Future<bool> updatePost(String id, {PostUpdate? body}) async {
    try {
      return UpdatePostRepo(id).update(body: body?.toJson());
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
