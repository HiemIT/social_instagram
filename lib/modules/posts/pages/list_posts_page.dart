import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_instagram/modules/posts/blocs/list_posts_bloc.dart';
import 'package:social_instagram/modules/posts/widgets/stateless/activity_indicator.dart';
import 'package:social_instagram/modules/posts/widgets/stateless/post_item_remake.dart';
import 'package:social_instagram/route/route_name.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/uidata.dart';

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  State<ListPostsPage> createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsBloc();
  final _controller = TextEditingController();
  late final ScrollController _scrollCtrl;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postsBloc.add('getPosts');
    _scrollCtrl = ScrollController();
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  /*@override
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
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGray,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppColors.white,
        backgroundColor: AppColors.darkGray,
        strokeWidth: 1.0,
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 1), () {
            _postsBloc.add('getPosts');
          });
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollCtrl,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: AppColors.darkGray,
              snap: true,
              floating: true,
              elevation: 1,
              forceElevated: true,
              title: Container(
                height: 38,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.dark,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    hintText: "Search",
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.createPostPage);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.redGoogle,
                      shadows: [
                        BoxShadow(
                          color: AppColors.darkGray,
                          offset: new Offset(10.0, 10.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ImageIcon(
                      AssetImage(UIData.iconCamera),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ListPostsBloc, ListPostsState>(
              bloc: _postsBloc,
              builder: (context, state) {
                final posts = state.posts;
                if (posts == null) {
                  return const SliverFillRemaining(
                    child: ActivityIndicator(),
                  );
                }
                final error = state.error;
                if (error != null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(error.toString()),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = posts[index];
                      return PostItemRemake(
                        post: item,
                      );
                    },
                    childCount: posts.length ?? 0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
