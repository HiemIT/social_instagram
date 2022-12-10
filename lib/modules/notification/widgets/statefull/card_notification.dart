import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/notification/models/notify.dart';
import 'package:social_instagram/themes/app_colors.dart';

import '../../../../utils/string_utils.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({Key? key, required this.notify}) : super(key: key);

  final Notify? notify;

  @override
  Widget build(BuildContext context) {
    final int? isRead = notify?.isRead ?? 1;
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: InkWell(
        onTap: () {},
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
                subtitle:
                    StringUtils().formatTimeAgo(notify?.createdAt as DateTime),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
