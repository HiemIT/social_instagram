import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/models/post.dart';

class ActionPost extends StatefulWidget {
  final Post post;
  const ActionPost({Key? key, required this.post}) : super(key: key);

  @override
  State<ActionPost> createState() => _ActionPostState();
}

class _ActionPostState extends State<ActionPost> {
  Post get post => widget.post;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.description != null && post.description!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: Text(
                post.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('onTap');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.heart,
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                  const IconPostComment(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IconPostComment extends StatelessWidget {
  const IconPostComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      child: const Icon(
        CupertinoIcons.conversation_bubble,
      ),
    );
  }
}
