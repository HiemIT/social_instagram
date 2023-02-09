import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/widgets/grid_image.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/action_post.dart';
import 'package:social_instagram/modules/setting/widgets/profile_page.dart';
import 'package:social_instagram/route/route_name.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/string_utils.dart';

class PostItem extends StatelessWidget {
  const PostItem({Key? key, required this.post, this.uid}) : super(key: key);

  final Post post;
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () {
          // push to detail post
          Navigator.pushNamed(context, RouteName.postDetailPage,
              arguments: [post, uid]);
        },
        child: Card(
          color: AppColors.transparent,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateToProfilePage(context, post.user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: ItemRow(
                      avatarUrl: post.user!.avatar!.url!,
                      title: '${post.user!.displayName}',
                      subtitle: StringUtils()
                          .formatTimeAgo(post.createdAt as DateTime),
                    ),
                  ),
                ),
                GridImage(photos: post.photos!),
                ActionPost(
                  post: post,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
