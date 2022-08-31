import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_instagram/modules/posts/blocs/list_posts_bloc.dart';
import 'package:social_instagram/modules/posts/widgets/post_item.dart';

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  State<ListPostsPage> createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postsBloc.add('getPosts');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPostsBloc, ListPostsState>(
      bloc: _postsBloc,
      builder: (context, state) {
        final posts = state.posts;
        if (posts != null) {
          return ListView.builder(
            itemBuilder: (_, int index) {
              final item = posts[index];
              return PostItem(
                height: 200,
                url: item.images?.first.url ?? '',
                description: item.description!,
              );
            },
            itemCount: posts.length,
          );
        }

        final error = state.error;
        if (error != null) {
          return Center(
            child: Text(error.toString()),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
