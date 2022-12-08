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
  late final StreamSubscription<BlocEvent> _subDeletePost;
  final ListPostPagingRepo _repo;

  ListPostsRxDartBloc() : _repo = ListPostPagingRepo() {
    _onLikeAndUnLikePostSub = AppEventBloc().listenManyEvents(
      listEventName: [
        EventName.likePostDetail,
        EventName.unLikePostDetail,
      ],
      handler: _onLikeAndUnlikePost,
    );
    _subDeletePost = AppEventBloc().listenEvent(
      eventName: EventName.deletePost,
      handler: _deletePost,
    );
    AppEventBloc().listenEvent(
      eventName: EventName.deletePost,
      handler: _deletePost,
    );
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

  void _onLikeAndUnlikePost(BlocEvent evt) {
    debugPrint('_onLikeAndUnlikePost ${evt.name}');

    final oldPosts = dataValue ?? [];

    final index = oldPosts.indexWhere((p) => p.id == evt.value);

    if (index == -1) {
      return;
    }

    final post = oldPosts[index];

    final likeCount = post.likeCounts;
    final eventIsLike = [EventName.likePostDetail].contains(evt.name);
    final likeCountNew = eventIsLike ? likeCount! + 1 : likeCount! - 1;

    post
      ..likeCounts = likeCountNew
      ..liked = eventIsLike;

    oldPosts[index] = post;

    dataSubject.sink.add(oldPosts.toList());
  }

  void _deletePost(BlocEvent evt) {
    final value = evt.value;
// print('_deletePost $value');
    if (value is String) {
      // value <=> id post
      dataSubject.sink
          .add(dataValue!.where((e) => e.id != value).toList()); // C1
      // C2: call api refresh list post
    }
  }

  @override
  void dispose() {
    _subDeletePost.cancel();
    _onLikeAndUnLikePostSub.cancel();
  }

  @override
  PagingRepo<Post> get dataRepo => _repo;
}
