import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/comment/blocs/comments_bloc.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/modules/comment/widgets/comment_item_bubble.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/themes/app_colors.dart';

class ListComment extends StatefulWidget {
  const ListComment({Key? key, required this.postId, required this.flag})
      : super(key: key);
  final String postId;
  final bool flag;

  @override
  State<ListComment> createState() => _ListCommentState();
}

class _ListCommentState extends State<ListComment> {
  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>?>(
      stream: commentBloc!.listCmtStream,
      builder: (context, snapshot) {
        final listCmt = snapshot;
        if (listCmt.data == null) {
          return Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CupertinoActivityIndicator(),
                ),
                Center(
                  child: Text('Loading...',
                      style: TextStyle(color: AppColors.grey)),
                ),
              ],
            ),
          );
        }
        if (listCmt.hasData) {
          if (listCmt.data!.isEmpty) {
            return Container(
              padding: EdgeInsets.only(top: 12.0),
              child: Center(
                child: Text('No comments yet',
                    style: TextStyle(fontSize: 16.0, color: AppColors.grey)),
              ),
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            itemCount: listCmt.data!.length,
            itemBuilder: (context, index) {
              final comment = snapshot.data![index];

              return Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: CommentItemBubble(
                    idPost: widget.postId,
                    comment: comment,
                    onReact: (int, bool) {},
                    flag: widget.flag,
                  ),
                ),
              );
            },
          );
        }

        if (listCmt.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CupertinoActivityIndicator(),
              ),
              Text("Loading...",
                  style: TextStyle(fontSize: 16.0, color: AppColors.grey)),
            ],
          ),
        );
      },
    );
  }
}
