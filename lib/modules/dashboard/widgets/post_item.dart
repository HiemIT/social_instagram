import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/widgets/grid_image.dart';

class PostItem extends StatefulWidget {
  final double? height;
  final Post? item;
  final String? description;

  const PostItem({
    Key? key,
    this.height,
    required this.item,
    required this.description,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late double? _height;
  late Post? _item;

  @override
  void initState() {
    _height = widget.height;
    _item = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF242A37),
        boxShadow: const [
          BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(3, 6))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              widget.description ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          GridImage(photos: _item?.photos ?? [])
        ],
      ),
    );
  }
}
