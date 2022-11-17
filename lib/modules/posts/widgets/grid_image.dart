import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/modules/posts/widgets/post_img_item.dart';
import 'package:social_instagram/modules/posts/widgets/statefull/full_photo.dart';
import 'package:social_instagram/utils/photo_utils.dart';

class GridImage extends StatelessWidget {
  final List<Photo> photos;
  final double padding;

  const GridImage({
    Key? key,
    required this.photos,
    this.padding = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - padding;
    return buildImageGrid(photos, width, context);
  }

  Widget buildImageGrid(
      List<Photo> photos, double width, BuildContext context) {
    switch (photos.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(photos[0], width, context);
      case 2:
        return _buildTwoImage(photos, width, context);
      case 3:
        return _buildThreeImage(photos, width, context);
      case 4:
        // TODO:
        return _buildFourImage(photos, width, context);
      case 5:
        // TODO:
        return _builderFiverImage(photos, width, context);
      default:
        return _buildOneImage(photos[0], width, context);
    }
  }

  Widget _buildOneImage(Photo photo, double width, BuildContext context) {
    final image = photo.image;
    final heightView =
        PhotoUtils.getHeightView(width, image!.orgWidth!, image.orgHeight!);
    final url =
        PhotoUtils.genImgIx(image.url, width.toInt(), heightView.toInt());

    // https://lh3.googleusercontent.com/a/
    // AATXAJzi4A6N_vMGnRHQte7WAJcmc18PUhgQH9fkyEzNTQ=s96-c?width=300&height=400;
    // images: 300x400

    if (heightView >= width * 2.5) {
      return GestureDetector(
        onTap: () => navigateToPhotoPage([photo], 0, context),
        child: SizedBox(
          height: width * 2.5,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => navigateToPhotoPage([photo], 0, context),
      child: SizedBox(
        height: heightView,
        width: width,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTwoImage(
      List<Photo> photos, double width, BuildContext context) {
    final firstImg = photos[0].image;

    // 2 tam cung dung
    // 2 tam cung ngang
    // xet dua tren tam dau tien
    // + 1: tam dau tien dung
    // + 2: tam dau tien ngang

    //

    if (firstImg!.orgWidth! > firstImg.orgHeight!) {
      final height = width - padding;
      return SizedBox(
        height: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PostImgItem(
              url: photos[0].url,
              width: width,
              height: height / 2,
              onTap: () => navigateToPhotoPage(photos, 0, context),
            ),
            _buildPadding(),
            PostImgItem(
              url: photos[1].url,
              width: width,
              height: height / 2,
              onTap: () => navigateToPhotoPage(photos, 0, context),
            ),
          ],
        ),
      );
    }

    final height = width;
    width = width - padding;
    return Row(
      children: <Widget>[
        PostImgItem(
          url: photos[0].url,
          width: width / 2,
          height: height,
          onTap: () => navigateToPhotoPage(photos, 0, context),
        ),
        _buildPadding(),
        PostImgItem(
          url: photos[1].url,
          width: width / 2,
          height: height,
          onTap: () => navigateToPhotoPage(photos, 0, context),
        ),
      ],
    );
  }

  _buildPadding() => Padding(
        padding: EdgeInsets.only(left: padding, top: padding),
      );

  Widget _buildThreeImage(
      List<Photo> photos, double width, BuildContext context) {
    final firstImg = photos[0].image;

    // first vertical style images
    if (firstImg!.orgHeight! > firstImg.orgWidth!) {
      final height = width;
      final itemHeight = height;
      final itemWidth = width - padding;
      return SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PostImgItem(
              url: photos[0].url,
              width: itemWidth / 2,
              height: itemHeight,
              onTap: () => navigateToPhotoPage(photos, 0, context),
            ),
            _buildPadding(),
            Column(
              children: <Widget>[
                PostImgItem(
                  url: photos[1].url,
                  width: itemWidth / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 1, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photos[2].url,
                  width: itemWidth / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 2, context),
                ),
              ],
            )
          ],
        ),
      );
    }

    final height = width;
    final itemWidth = (width - padding) / 2;
    final itemHeight = (height - padding) / 2;
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              PostImgItem(
                url: photos[1].url,
                width: itemWidth,
                height: itemHeight,
                onTap: () => navigateToPhotoPage(photos, 1, context),
              ),
              _buildPadding(),
              PostImgItem(
                url: photos[2].url,
                width: itemWidth,
                height: itemHeight,
                onTap: () => navigateToPhotoPage(photos, 2, context),
              ),
            ],
          ),
          _buildPadding(),
          PostImgItem(
            url: photos[0].url,
            width: width,
            height: itemHeight,
            onTap: () => navigateToPhotoPage(photos, 0, context),
          ),
        ],
      ),
    );
  }

  Widget _buildFourImage(
      List<Photo> photo, double width, BuildContext context) {
    final firstImg = photo[0].image;

    if (firstImg!.orgHeight! > firstImg.orgWidth!) {
      final height = width;
      final itemHeight = height;
      final itemWidth = width - padding;
      return SizedBox(
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PostImgItem(
              url: photo[0].url,
              width: itemWidth / 2,
              height: itemHeight,
              onTap: () => navigateToPhotoPage(photos, 0, context),
            ),
            _buildPadding(),
            Column(
              children: [
                PostImgItem(
                  url: photo[1].url,
                  width: itemWidth / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 1, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photo[2].url,
                  width: itemWidth / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 2, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photo[3].url,
                  width: itemWidth / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 3, context),
                ),
              ],
            )
          ],
        ),
      );
    }

    final height = width;
    final itemWidth = (width - padding) / 2;
    final itemHeight = (height - padding) / 2;
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PostImgItem(
            url: photo[0].url,
            width: width,
            height: itemHeight,
            onTap: () => navigateToPhotoPage(photos, 0, context),
          ),
          _buildPadding(),
          Row(
            children: [
              PostImgItem(
                url: photo[1].url,
                width: itemWidth,
                height: itemHeight,
                onTap: () => navigateToPhotoPage(photos, 1, context),
              ),
              _buildPadding(),
              PostImgItem(
                url: photo[2].url,
                width: itemWidth,
                height: itemHeight,
                onTap: () => navigateToPhotoPage(photos, 2, context),
              ),
              _buildPadding(),
              PostImgItem(
                url: photo[3].url,
                width: itemWidth,
                height: itemHeight,
                onTap: () => navigateToPhotoPage(photos, 3, context),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildFiverImage(List<Photo> photos, double width, BuildContext context) {
  //   final firstImg = photos[0].image;
  //
  //   if (firstImg!.orgHeight! > firstImg.orgWidth!) {
  //     final height = width;
  //     final itemHeight = height;
  //     final itemWidth = width - padding;
  //
  //     return SizedBox(
  //       height: height,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Column(
  //             children: [
  //               PostImgItem(
  //                 url: photos[0].url,
  //                 width: (width + padding) / 2,
  //                 height: (itemHeight - padding) / 2,
  //                 onTap: () => navigateToPhotoPage(photos, 0, context),
  //               ),
  //               _buildPadding(),
  //               PostImgItem(
  //                 url: photos[1].url,
  //                 width: (width + padding) / 2,
  //                 height: (itemHeight - padding) / 2,
  //                 onTap: () => navigateToPhotoPage(photos, 0, context),
  //               ),
  //             ],
  //           ),
  //           _buildPadding(),
  //           Column(
  //             children: [
  //               PostImgItem(
  //                 url: photos[2].url,
  //                 width: (width + padding),
  //                 height: itemHeight,
  //                 onTap: () => navigateToPhotoPage(photos, 0, context),
  //               ),
  //               _buildPadding(),
  //               PostImgItem(
  //                 url: photos[3].url,
  //                 width: (width + padding),
  //                 height: itemHeight,
  //                 onTap: () => navigateToPhotoPage(photos, 0, context),
  //               ),
  //               _buildPadding(),
  //               PostImgItem(
  //                 url: photos[4].url,
  //                 width: (width + padding),
  //                 height: itemHeight,
  //                 onTap: () => navigateToPhotoPage(photos, 0, context),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     );
  //   }
  //   final height = width;
  //   final itemWidth = (width - padding) / 2;
  //   final itemHeight = (height - padding) / 2;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Row(
  //         children: [
  //           PostImgItem(
  //             url: photos[0].url,
  //             width: itemWidth,
  //             height: itemHeight,
  //             onTap: () => navigateToPhotoPage(photos, 1, context),
  //           ),
  //           _buildPadding(),
  //           PostImgItem(
  //             url: photos[1].url,
  //             width: itemWidth,
  //             height: itemHeight,
  //             onTap: () => navigateToPhotoPage(photos, 1, context),
  //           ),
  //         ],
  //       ),
  //       _buildPadding(),
  //       Row(
  //         children: [
  //           PostImgItem(
  //             url: photos[2].url,
  //             width: itemWidth / 2,
  //             height: (itemHeight - padding) / 2,
  //             onTap: () => navigateToPhotoPage(photos, 1, context),
  //           ),
  //           _buildPadding(),
  //           PostImgItem(
  //             url: photos[3].url,
  //             width: itemWidth / 2,
  //             height: (itemHeight - padding) / 2,
  //             onTap: () => navigateToPhotoPage(photos, 1, context),
  //           ),
  //           _buildPadding(),
  //           PostImgItem(
  //             url: photos[4].url,
  //             width: itemWidth / 2,
  //             height: (itemHeight - padding) / 2,
  //             onTap: () => navigateToPhotoPage(photos, 1, context),
  //           ),
  //         ],
  //       )
  //     ],
  //   );
  // }

  // builder widget fiver image
  Widget _builderFiverImage(
      List<Photo> photos, double width, BuildContext context) {
    final firstImg = photos[0].image;
    if (firstImg!.orgHeight! > firstImg.orgWidth!) {
      final height = width;
      final itemHeight = height;
      final itemWidth = width - padding;
      return SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                PostImgItem(
                  url: photos[0].url,
                  width: (width + padding) / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 0, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photos[1].url,
                  width: (width + padding) / 2,
                  height: (itemHeight - padding) / 2,
                  onTap: () => navigateToPhotoPage(photos, 1, context),
                ),
              ],
            ),
            _buildPadding(),
            Column(
              children: [
                PostImgItem(
                  url: photos[2].url,
                  width: (width + padding),
                  height: itemHeight,
                  onTap: () => navigateToPhotoPage(photos, 2, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photos[3].url,
                  width: (width + padding),
                  height: itemHeight,
                  onTap: () => navigateToPhotoPage(photos, 3, context),
                ),
                _buildPadding(),
                PostImgItem(
                  url: photos[4].url,
                  width: (width + padding),
                  height: itemHeight,
                  onTap: () => navigateToPhotoPage(photos, 4, context),
                ),
              ],
            )
          ],
        ),
      );
    }
    final height = width;
    final itemWidth = (width - padding) / 2;
    final itemHeight = (height - padding) / 2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            PostImgItem(
              url: photos[0].url,
              width: itemWidth,
              height: itemHeight,
              onTap: () => navigateToPhotoPage(photos, 0, context),
            ),
            _buildPadding(),
            PostImgItem(
              url: photos[1].url,
              width: itemWidth,
              height: itemHeight,
              onTap: () => navigateToPhotoPage(photos, 1, context),
            ),
          ],
        ),
        _buildPadding(),
        Row(
          children: [
            PostImgItem(
              url: photos[2].url,
              width: itemWidth / 2,
              height: (itemHeight - padding) / 2,
              onTap: () => navigateToPhotoPage(photos, 2, context),
            ),
            _buildPadding(),
            PostImgItem(
              url: photos[3].url,
              width: itemWidth / 2,
              height: (itemHeight - padding) / 2,
              onTap: () => navigateToPhotoPage(photos, 3, context),
            ),
            _buildPadding(),
            PostImgItem(
              url: photos[4].url,
              width: itemWidth / 2,
              height: (itemHeight - padding) / 2,
              onTap: () => navigateToPhotoPage(photos, 4, context),
            ),
          ],
        )
      ],
    );
  }

  void navigateToPhotoPage(
      List<Photo> photos, int index, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullPhoto(
          photos: photos,
          id: index,
        ),
      ),
    );
    print('navigateToPhotoPage $index');
  }
}
