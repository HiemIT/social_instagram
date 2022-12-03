import 'package:flutter/material.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';
import 'package:social_instagram/utils/date_format_until.dart';

class ReactionComment extends StatefulWidget {
  const ReactionComment({Key? key, required this.comment}) : super(key: key);

  // final DateTime createAt;
  final Comment comment;

  @override
  State<ReactionComment> createState() => _ReactionCommentState();
}

class _ReactionCommentState extends State<ReactionComment> {
  Comment get comment => widget.comment;

  // CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);
  DateTime? get timeAgo => comment.createdAt;
  late bool isLike = false;

  @override
  void initState() {
    super.initState();
    isLike = comment.liked!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //  time
        Text(
          DateFormatUntil.dateFormat(timeAgo!),
          style: AppTextStyle.datimepost,
        ),
        SizedBox(
          width: 10,
        ),
        //  reaction like
        GestureDetector(
          onTap: () {},
          child: !isLike
              ? Text(
                  "Thích",
                  style: AppTextStyle.datimepost,
                )
              : Text(
                  "Thích",
                  style: AppTextStyle.datimepost
                      .copyWith(color: AppColors.redSend),
                ),
        ),
        //  reaction reply comment
      ],
    );
  }
}
