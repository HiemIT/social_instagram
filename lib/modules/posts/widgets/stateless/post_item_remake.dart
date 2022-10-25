import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/widgets/grid_image.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/action_post.dart';
import 'package:social_instagram/themes/app_colors.dart';

class PostItemRemake extends StatelessWidget {
  const PostItemRemake({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          print('onTap');
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: ItemRow(
                    avatarUrl: post.user!.avatar!.url! ??
                        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80",
                    title:
                        '${post.user!.firstName! + ' ' + post.user!.lastName!}',
                    subtitle: formatTimeAgo(post.createdAt!),
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

  String formatTimeAgo(String time) {
    final date = DateTime.parse(time);
    final difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      if (difference.inDays > 1) {
        return '${date.day}/${date.month}/${date.year}';
      } else {
        return 'Hôm qua';
      }
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}
