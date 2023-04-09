import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/profileUser/blocs/profile_user_bloc.dart';

import '../../../../themes/app_colors.dart';
import '../../../posts/models/post.dart';
import '../../../posts/widgets/stateless/activity_indicator.dart';
import '../../../posts/widgets/stateless/post_item.dart';

class UserPostView extends StatefulWidget {
  UserPostView({Key? key, required this.currentUser}) : super(key: key);

  final ProfileUserBloc? currentUser;

  @override
  State<UserPostView> createState() => _UserPostViewState();
}

class _UserPostViewState extends State<UserPostView> {
  get postBloc => widget.currentUser;

  late final _scrollCtrl = ScrollController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      color: AppColors.white,
      backgroundColor: AppColors.dark,
      onRefresh: () async {
        await postBloc.getPosts();
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollCtrl,
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: postBloc?.getPosts,
          ),
          StreamBuilder<List<Post>?>(
              stream: postBloc?.postStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          child: PostItem(
                            isProfile: true,
                            post:
                                snapshot.data![index], // postBloc.posts[index]
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: ActivityIndicator(),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
