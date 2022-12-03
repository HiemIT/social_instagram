import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/comment/blocs/comments_bloc.dart';
import 'package:social_instagram/modules/posts/blocs/post_detail_bloc.dart';
import 'package:social_instagram/modules/posts/widgets/grid_image.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/action_post.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/build_comment_box.dart';
import 'package:social_instagram/modules/profile/pages/profile_page.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/string_utils.dart';

import '../../comment/widgets/list_comment.dart';
import '../models/post.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Post get post => widget.post;

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);

  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);
  TextEditingController commentsTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentBloc!.getComments();
    bloc?.getPost();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: StreamBuilder<Post>(
        stream: bloc!.postsStream,
        initialData: widget.post,
        builder: (context, snapshot) {
          final post = snapshot.data;
          return Stack(
            children: [
              CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: AppColors.darkGray,
                    centerTitle: true,
                    title: Text('${post?.user?.displayName}'),
                    snap: true,
                    floating: true,
                    elevation: 1,
                    forceElevated: true,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  CupertinoSliverRefreshControl(
                    onRefresh: bloc!.getPost,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        InkWell(
                          onTap: () =>
                              navigateToProfilePage(context, post!.user),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
                            child: ItemRow(
                              title:
                                  '${post?.user?.firstName} ${post?.user?.lastName}',
                              subtitle: StringUtils()
                                  .formatTimeAgo(post?.createdAt as DateTime),
                              avatarUrl: post?.user?.avatar?.url ?? '',
                            ),
                          ),
                        ),
                        if (post!.photos != null)
                          GridImage(
                            photos: post.photos!,
                            padding: 0,
                          ),
                        ActionPost(
                          post: post,
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        const ListComment(),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BuildCommentBox(),
    );
  }
}
