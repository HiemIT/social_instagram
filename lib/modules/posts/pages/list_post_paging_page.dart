import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/mixin/scroll_page_mixin.dart';
import '../../../route/route_name.dart';
import '../../../themes/app_colors.dart';
import '../blocs/list_posts_rxdart_bloc.dart';
import '../models/post.dart';
import '../widgets/stateless/activity_indicator.dart';
import '../widgets/stateless/post_item_remake.dart';

class ListPostPagingPage extends StatefulWidget {
  const ListPostPagingPage({Key? key}) : super(key: key);

  @override
  State<ListPostPagingPage> createState() => _ListPostsPagingPageState();
}

class _ListPostsPagingPageState extends State<ListPostPagingPage>
    with ScrollPageMixin {
  final _postsBloc = ListPostsRxDartBloc();
  late final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _postsBloc.getPosts();
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, RouteName.createPostPage),
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollCtrl,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColors.dark,
            title: const Text('Post'),
            snap: true,
            floating: true,
            elevation: 1,
            forceElevated: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/day09');
                  },
                  icon: const Icon(Icons.ac_unit))
            ],
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _postsBloc.getPosts,
          ),
          StreamBuilder<List<Post>?>(
              stream: _postsBloc.postsStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SliverFillRemaining(
                    child: ActivityIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const SliverFillRemaining(
                      child: Center(
                    child: Text('Something went wrong'),
                  ));
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final post = snapshot.data![index];
                      return PostItemRemake(post: post);
                    },
                    childCount: snapshot.data?.length ?? 0,
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  void loadMoreData() => _postsBloc.getPosts();

  @override
  ScrollController get scrollController => _scrollCtrl;
}
