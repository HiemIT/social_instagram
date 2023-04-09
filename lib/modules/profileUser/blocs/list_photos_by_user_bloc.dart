import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

import '../repos/photos_paging_repo.dart';

class ListPhotoByUserBloc extends PagingDataBehaviorBloc<Photo> {
  final PhotosUserPagingRepo _photosUserPagingRepo;

  Stream<List<Photo>?> get postStream => dataStream;

  ListPhotoByUserBloc(this._photosUserPagingRepo) {
    getPhotos();
  }

  Future<void> getPhotos() async {
    return getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  PagingRepo<Photo> get dataRepo => _photosUserPagingRepo;
}
