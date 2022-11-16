import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullPhoto extends StatelessWidget {
  final String url;

  FullPhoto({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
        controller: PhotoViewController(
          initialPosition: const Offset(0.0, 0.0),
          initialRotation: 0.0,
        ),
        initialScale: PhotoViewComputedScale.contained,
        imageProvider: CachedNetworkImageProvider(url),
      ),
    );
  }
}
