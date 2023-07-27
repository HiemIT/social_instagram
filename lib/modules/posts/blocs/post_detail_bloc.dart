import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/common/blocs/app_even_bloc.dart';
import 'package:social_instagram/modules/posts/blocs/update_post_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/repos/post_detail_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

import '../../profileUser/repos/profile_repo.dart';
import '../models/post_update.dart';
import 'delete_post_bloc.dart';

class PostDetailBloc extends BlocBase {
  final String _postId;
  final updatePostBloc = UpdatePostBloc();
  final deletePostBloc = DeletePostBloc();
  final profileRepo = ProfileRepo();
  // gắn _postCtrl với BehaviorSubject để có thể lắng nghe và gửi dữ liệu
  final _postCtrl = BehaviorSubject<Post>();

  // lấy dữ liệu từ _postCtrl để hiển thị lên UI
  Stream<Post> get postsStream => _postCtrl.stream;

  // PostDetailBloc(this._postId) `truyền vào _postId để có thể lấy dữ liệu từ API
  PostDetailBloc(this._postId);

  Future<void> getPost() async {
    try {
      final response = await PostDetailRepo().getPost(_postId);

      if (response != null) {
        _postCtrl.sink.add(response);
      }
    } catch (e) {
      _postCtrl.sink.addError("Cannot get post detail right now");
    }
  }

  Future<void> updatePost(PostUpdate postUpdate) async {
    try {
      final res = await updatePostBloc.updatePost(_postId, body: postUpdate);
      if (res) {
        AppEventBloc().emitEvent(BlocEvent(EventName.updatePost, postUpdate));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost() async {
    try {
      // AppEventBloc().emitEvent(
      //   BlocEvent(EventName.deletePost, _postId),
      // );
      // return;
      final res = await deletePostBloc.deletePost(_postId);
      if (res) {
        AppEventBloc().emitEvent(BlocEvent(EventName.deletePost, _postId));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _postCtrl.close();
  }
}

/*
* TODO: Xóa bài viết của mình
*  -  Đầu tiên ta cần xác định đó là bài viết của mình.
*  - Nếu nó là bài viết của m
*  */
