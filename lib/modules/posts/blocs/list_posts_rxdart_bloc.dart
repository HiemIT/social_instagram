import 'package:rxdart/subjects.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/repos/list_posts_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class ListPostsRxDartBloc extends BlocBase {
  // ở đây mình sẽ tạo ra 1 stream để lắng nghe sự kiện
  final _postsCtrl = BehaviorSubject<List<Post>?>();

  // sử dụng getter để lấy ra stream
  Stream<List<Post>?> get postsStream => _postsCtrl.stream;

  // hàm này để lấy dữ liệu từ server về
  Future<void> getPosts() async {
    try {
      final res = await ListPostsRepo().getPosts();
      if (res != null) {
        _postsCtrl.sink.add(res);
      }
    } catch (e) {
      _postsCtrl.sink.addError("Cannot fetch list posts right now");
    }
  }

  @override
  void dispose() {
    _postsCtrl.close();
  }
}
