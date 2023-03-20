import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/item_row.dart';
import 'package:social_instagram/modules/comment/blocs/comments_bloc.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/reaction_comment.dart';

import '../../../providers/bloc_provider.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../profile/widgets/stateless/item_block.dart';

class CommentItemBubble extends StatefulWidget {
  final Comment? comment;
  final Function(int, bool) onReact;
  final String idPost;
  final bool flag;

  const CommentItemBubble({
    Key? key,
    required this.comment,
    required this.onReact,
    required this.idPost,
    required this.flag,
  }) : super(key: key);

  @override
  State<CommentItemBubble> createState() => _CommentItemBubbleState();
}

class _CommentItemBubbleState extends State<CommentItemBubble> {
  // idPost
  String get idPost => widget.idPost;
  late final Comment cmt;
  int? yourReact = 0;

  CommentBloc? get bloc => BlocProvider.of<CommentBloc>(context);

  @override
  void initState() {
    super.initState();

    cmt = widget.comment!;
    yourReact = cmt.metaData?.yourReact ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: Column(
            children: [
              ItemRow(
                avatarUrl: cmt.urlUserAvatar,
                title: "${cmt.displayName}",
                subtitle: '${cmt.content}',
                maxLines: 1,
                sizeAvatar: 32,
                isCmt: true,
                rightWidget: widget.flag ? showOption() : null,
              ),
              SizedBox(
                height: 10,
              ),
              ReactionComment(comment: widget.comment!),
            ],
          ),
        ),
      ],
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
                                  'Chỉnh sữa bình luận',
                                  style: AppTextStyle.caption,
                                ),
                                onTap: () {},
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
                                onTap: deleteCmt,
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

  Future<void> deleteCmt() async {
    try {
      return await bloc!.deleteCmt(idPost, cmt.id!).then((value) {
        Navigator.pop(context);
      });
    } catch (e) {}
  }
}
