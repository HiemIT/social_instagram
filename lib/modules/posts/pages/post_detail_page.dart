import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/posts/blocs/post_detail_bloc.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/route/route_name.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/string_utils.dart';

import '../../../themes/app_text_style.dart';
import '../../comment/widgets/list_comment.dart';
import '../../profile/widgets/stateless/item_block.dart';
import '../models/post.dart';
import '../widgets/grid_image.dart';
import '../widgets/statefull/action_post.dart';
import '../widgets/statefull/build_comment_box.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  final String? id;

  const PostDetailPage({
    Key? key,
    required this.post,
    this.id,
  }) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Post get post => widget.post;
  String? get id => widget.id;

  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);

  TextEditingController commentsTEC = TextEditingController();
  bool flag = false;

  @override
  void initState() {
    super.initState();
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
                        GestureDetector(
                          onTap: () => {},
                          // navigateToProfilePage(context, post!.user),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
                            child: ItemRow(
                              title: '${post?.user?.displayName} ',
                              subtitle: StringUtils()
                                  .formatTimeAgo(post?.createdAt as DateTime),
                              avatarUrl: post?.user?.avatar?.url ?? '',
                              rightWidget: (flag = (id == post?.user?.id))
                                  ? showOption()
                                  : null,
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
                        ListComment(
                          postId: post.id!,
                          flag: flag,
                        ),
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

  Widget showOption() {
    final size = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                // <-- SEE HERE
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            backgroundColor: AppColors.dark,
            elevation: 0,
            builder: (context) {
              return SizedBox(
                // height: size / 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.slate,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: ItemBlock(
                                leading: const Icon(Icons.edit,
                                    color: AppColors.white),
                                title: const Text(
                                  'Chỉnh sữa bài viết',
                                  style: AppTextStyle.caption,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteName.updatePostPage,
                                      arguments: post);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.slate,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: ItemBlock(
                                leading: const Icon(Icons.delete_forever,
                                    color: AppColors.white),
                                title: const Text(
                                  'Xóa',
                                  style: AppTextStyle.caption,
                                ),
                                onTap: deletePost,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Icon(Icons.more_horiz, color: AppColors.slate),
    );
  }

  Future<void> deletePost() async {
    try {
      return bloc!.deletePost().then((value) {
        Navigator.popUntil(context, (route) => route.settings.name == '/');
      });
    } catch (e) {}
  }
}
