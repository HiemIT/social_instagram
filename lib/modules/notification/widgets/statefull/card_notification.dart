import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/notification/models/notify.dart';
import 'package:social_instagram/modules/posts/blocs/post_detail_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/themes/app_colors.dart';

import '../../../../common/blocs/app_even_bloc.dart';
import '../../../../route/route_name.dart';
import '../../../../utils/string_utils.dart';
import '../../repos/read_notification_repo.dart';

class CardNotification extends StatelessWidget {
  const CardNotification(
      {Key? key, required this.notify, required this.context, required this.id})
      : super(key: key);
  final BuildContext context;

  final Notify? notify;

  final String id;

  @override
  Widget build(BuildContext context) {
    final int? isRead = notify?.isRead ?? 1;
    var postId = notify?.postId ?? 0 as String;
    final PostDetailBloc _postDetailBloc = PostDetailBloc(postId)..getPost();
    return StreamBuilder<Post?>(
        stream: _postDetailBloc.postsStream,
        builder: (context, snapshot) {
          final post = snapshot.data;
          return (post != null)
              ? Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: InkWell(
                    onTap: () async {
                      await handleReadNotify(context, post);
                    },
                    child: Card(
                      color: isRead == 1
                          ? Theme.of(context).primaryColor
                          : AppColors.softBlue.withOpacity(0.1),
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                          child: ItemRow(
                            maxLines: 2,
                            sizeAvatar: 60,
                            avatarUrl: notify?.payload?.user?.imgUrl,
                            title: '${notify?.payload?.title} ',
                            subtitle: StringUtils()
                                .formatTimeAgo(notify?.createdAt as DateTime),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        });
  }

  Future<void> handleReadNotify(BuildContext context, [Post? post]) async {
    try {
      if (notify!.isRead == 1) {
        Navigator.pushNamed(
          context,
          RouteName.postDetailPage,
          arguments: [post, id],
        );
      }

      final res =
          await ReadNotificationRepo(notify!.id ?? "").readNotification();

      if (res) {
        notify!.isRead = 1;
        AppEventBloc().emitEvent(BlocEvent(EventName.readNotifiCation, notify));

        // Thực hiện chuyển hướng tới trang chi tiết bài viết
        Navigator.pushNamed(
          context,
          RouteName.postDetailPage,
          arguments: [post, id],
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
