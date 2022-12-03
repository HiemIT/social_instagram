import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/repos/list_post_paging_repo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

import '../../../common/blocs/app_even_bloc.dart';

// class ListPostsRxDartBloc extends BlocBase {
//   // ở đây mình sẽ tạo ra 1 stream để lắng nghe sự kiện
//   final _postsCtrl = BehaviorSubject<List<Post>?>();
//
//   // sử dụng getter để lấy ra stream
//   Stream<List<Post>?> get postsStream => _postsCtrl.stream;
//
//   // hàm này để lấy dữ liệu từ server về
//   Future<void> getPosts() async {
//     try {
//       final res = await ListPostsRepo().getPosts();
//       if (res != null) {
//         _postsCtrl.sink.add(res);
//       }
//     } catch (e) {
//       _postsCtrl.sink.addError("Cannot fetch list posts right now");
//     }
//   }
//
//   @override
//   void dispose() {
//     _postsCtrl.close();
//   }
// }

class ListPostsRxDartBloc extends PagingDataBehaviorBloc<Post> {
  Stream<List<Post>?> get postsStream => dataStream;

  late final StreamSubscription<BlocEvent> _onLikeAndUnLikePostSub;
  final ListPostPagingRepo _repo;

  ListPostsRxDartBloc() : _repo = ListPostPagingRepo() {
    _onLikeAndUnLikePostSub:
    AppEventBloc().listenManyEvents(
      listEventName: [
        EventName.likePostDetail,
        EventName.unLikePostDetail,
      ],
      handler: _onLikeAndUnlikePost,
    );
  }

  Future<void> getPosts() async {
    return getData();
  }

  void _onLikeAndUnlikePost(BlocEvent event) {
    debugPrint('_onLikeAndUnlikePost ${event.name}');

    final oldPosts = dataValue ?? [];
  }

  @override
  PagingRepo<Post> get dataRepo => _repo;
}
