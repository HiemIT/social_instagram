import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:social_instagram/modules/posts/models/photo.dart';

class FullPhoto extends StatefulWidget {
  final int id;
  final List<Photo> photos;

  FullPhoto({Key? key, required this.photos, required this.id})
      : super(key: key);

  @override
  State<FullPhoto> createState() => _FullPhotoState();
}

class _FullPhotoState extends State<FullPhoto> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = widget.id;
    return Container(
      child: PhotoViewGallery.builder(
        itemCount: widget.photos.length,
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
              widget.photos[index].url,
            ),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(initialPage: widget.id),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
    // return Container(
    //   constraints: BoxConstraints.expand(
    //     height: MediaQuery.of(context).size.height,
    //   ),
    //   child: PhotoViewGallery.builder(
    //     itemCount: widget.photos.length,
    //     builder: (context, index) {
    //       return PhotoViewGalleryPageOptions(
    //         imageProvider:
    //             CachedNetworkImageProvider(widget.photos[index].url!),
    //         initialScale: PhotoViewComputedScale.contained,
    //         minScale: PhotoViewComputedScale.contained,
    //         maxScale: PhotoViewComputedScale.covered * 2,
    //         heroAttributes:
    //             PhotoViewHeroAttributes(tag: widget.photos[index].id as Object),
    //       );
    //     },
    //     scrollPhysics: const BouncingScrollPhysics(),
    //     backgroundDecoration: const BoxDecoration(
    //       color: Colors.black,
    //     ),
    //     loadingBuilder: (context, event) => Center(
    //       child: Container(
    //         width: 20.0,
    //         height: 20.0,
    //         child: CircularProgressIndicator(
    //           value: event == null
    //               ? 0
    //               : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
