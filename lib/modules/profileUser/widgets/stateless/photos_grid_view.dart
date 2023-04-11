import 'package:flutter/material.dart';

import '../../../posts/models/photo.dart';
import '../../blocs/profile_user_bloc.dart';
import 'custom_masonry_gird_photos.dart';

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final ProfileUserBloc? currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Photo>?>(
      stream: currentUser?.photosStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        final photos = snapshot.data;

        return CustomMasonryGirdPhotos(photos: photos);
      },
    );
  }
}
