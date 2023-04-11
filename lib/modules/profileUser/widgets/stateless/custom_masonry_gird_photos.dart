import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_instagram/utils/extensions/extensions.dart';

import '../../../../themes/app_colors.dart';
import '../../../posts/models/photo.dart';
import '../../../posts/widgets/statefull/full_photo.dart';

class CustomMasonryGirdPhotos extends StatelessWidget {
  const CustomMasonryGirdPhotos({
    Key? key,
    required this.photos,
  }) : super(key: key);

  final List<Photo>? photos;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: const EdgeInsets.only(top: 10),
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: photos?.length ?? 0, // list of posts
      itemBuilder: (context, index) {
        final photo = photos?[index] ?? [] as Photo;
//
        final heightImage = context.countHeightPhoto(
            crossAxisCount: 2,
            width: photo.image?.orgWidth ?? 0,
            height: photo.image?.orgHeight ?? 0);
        final widthImage = context.screenSize.width / 2;
        return GestureDetector(
          onTap: () => navigateToPhotoPage(photos!, index, context),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: heightImage,
              width: widthImage,
              color: AppColors.black,
              child: CachedNetworkImage(
                imageUrl: photo.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: widthImage,
                  height: heightImage,
                  color: AppColors.blueGrey,
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
          ),
        );
      },
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
