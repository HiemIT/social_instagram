import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/repos/list_posts_repo.dart';

class ListPostsBloc extends Bloc<String, ListPostsState> {
  ListPostsBloc() : super(ListPostsState()) {
    on<String>(
      (event, emit) async {
        switch (event) {
          case 'getPosts':
            try {
              final res = await ListPostsRepo().getPosts();
              if (res != null) {
                emit(ListPostsState(posts: res));
              }
            } catch (e) {
              emit(ListPostsState(error: e));
            }
            break;
          default:
            // in a real app, a separate event type should be used
            print("Em sai r");
        }
      },
    );
  }
}

class ListPostsState {
  final Object? error;
  final List<Post>? posts;

  final List<String>? tagList;
  final String? tagQuery;

  ListPostsState({
    this.error,
    this.posts,
    this.tagList,
    this.tagQuery,
  });

  ListPostsState copyWith({
    Object? error,
    List<Post>? posts,
    List<String>? tagList,
    String? tagQuery,
  }) =>
      ListPostsState(
        error: error ?? this.error,
        posts: posts ?? this.posts,
        tagList: tagList ?? this.tagList,
        tagQuery: tagQuery ?? this.tagQuery,
      );
}
