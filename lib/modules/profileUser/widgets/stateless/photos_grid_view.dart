import 'package:flutter/material.dart';

import '../../../../common/mixin/scroll_page_mixin.dart';
import '../../../posts/models/photo.dart';
import '../../blocs/profile_user_bloc.dart';
import 'custom_masonry_gird_photos.dart';

class PhotosGridView extends StatefulWidget {
  const PhotosGridView({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final ProfileUserBloc? currentUser;

  @override
  State<PhotosGridView> createState() => _PhotosGridViewState();
}

class _PhotosGridViewState extends State<PhotosGridView> with ScrollPageMixin {
  late final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  ProfileUserBloc? get currentUser => widget.currentUser;
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

  @override
  void loadMoreData() => currentUser?.getPhotos();

  @override
  ScrollController get scrollController => _scrollCtrl;
}
