import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/toggle.dart';
import 'package:social_instagram/themes/app_colors.dart';

class ActionPost extends StatefulWidget {
  final Post post;
  const ActionPost({Key? key, required this.post}) : super(key: key);

  @override
  State<ActionPost> createState() => _ActionPostState();
}

class _ActionPostState extends State<ActionPost> {
  Post get post => widget.post;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = post.liked ?? false;
  }

  @override
  void didUpdateWidget(covariant ActionPost oldWidget) {
    if (widget.post != oldWidget.post) {
      isLiked = widget.post.liked ?? false;
    }
    super.didUpdateWidget(oldWidget);
  }

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
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 4),
                    child: Row(
                      children: [
                        Toggle(
                          isActivated: isLiked,
                          deActivatedChild: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8),
                            child: const Icon(
                              CupertinoIcons.heart_solid,
                              color: Colors.white,
                            ),
                          ),
                          activatedChild: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              CupertinoIcons.heart_solid,
                              color: AppColors.redGoogle,
                            ),
                          ),
                          onTrigger: (isLiked) async {},
                          onTap: (isOn) async {
                            setState(
                              () {
                                isLiked = isOn;
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatCount(post.likeCounts ?? 0),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  Row(
                    children: [
                      const IconPostComment(),
                      const SizedBox(width: 4),
                      Text(
                        formatCount(post.commentCounts ?? 0),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
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
        CupertinoIcons.chat_bubble_text_fill,
        color: Colors.white,
      ),
    );
  }
}

// function format count
String formatCount(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (count < 1000000) {
    return (count / 1000).toStringAsFixed(1) + 'K';
  } else {
    return (count / 1000000).toStringAsFixed(1) + 'M';
  }
}