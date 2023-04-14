import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/utils/extensions/extensions.dart';

import '../../../../common/mixin/download_img_mixin.dart';
import '../../../../themes/app_colors.dart';

class FullPhoto extends StatefulWidget {
  final int id;
  final List<Photo> photos;

  FullPhoto({Key? key, required this.photos, required this.id})
      : super(key: key);

  @override
  State<FullPhoto> createState() => _FullPhotoState();
}

class _FullPhotoState extends State<FullPhoto> with DownloadImgMixinStateful {
  // create get variable id and photos
  int get photoId => widget.id;
  List<Photo> get photos => widget.photos;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    int _currentIndex = widget.id;
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _takePhoto,
            icon: Icon(Icons.file_download_outlined, size: 30),
          ),
          SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          itemCount: photos.length,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              key: ValueKey(photos[index].id),
              imageProvider: CachedNetworkImageProvider(
                photos[index].url,
              ),
              onTapDown: (context, details, controllerValue) {
                Navigator.pop(context);
              },
              onScaleEnd: (context, details, controllerValue) {
                Navigator.pop(context);
              },
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              basePosition: Alignment.center,
            );
          },
          pageController: PageController(initialPage: _currentIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  void _takePhoto() async {
    bool result = await downloadImg(
      'DOFHunt_IMG_${photos[photoId].id.toString()}',
      photos[photoId].url,
    );

    if (result) {
      context.showSnackBar('Đã lưu thành công');
    }
    context.showSnackBar('Lưu không thành công');
  }
}
