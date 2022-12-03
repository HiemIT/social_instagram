import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/repos/post_detail_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class PostDetailBloc extends BlocBase {
  final String _postId;

  // gắn _postCtrl với BehaviorSubject để có thể lắng nghe và gửi dữ liệu
  final _postCtrl = BehaviorSubject<Post>();

  // lấy dữ liệu từ _postCtrl để hiển thị lên UI
  Stream<Post> get postsStream => _postCtrl.stream;

  // PostDetailBloc(this._postId) truyền vào _postId để có thể lấy dữ liệu từ API
  PostDetailBloc(this._postId);

  Future<void> getPost() async {
    try {
      final response = await PostDetailRepo().getPost(_postId);

      //   check res có null khônh
      if (response != null) {
        _postCtrl.sink.add(response);
      }
    } catch (e) {
      _postCtrl.sink.addError("Cannot get post detail right now");
    }
  }

  @override
  void dispose() {
    _postCtrl.close();
  }
}
