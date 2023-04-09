import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/models/post.dart';

class CustomMasonryGirdPhotos extends StatelessWidget {
  const CustomMasonryGirdPhotos({
    Key? key,
    required this.photos,
    required this.onRefresh,
    this.shrinkWrap = false,
  }) : super(key: key);
  final List<Post> photos;
  final Future<void> Function() onRefresh;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(),
      ),
    );
  }
}
