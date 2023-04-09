import 'package:social_instagram/modules/posts/models/photo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

class PhotosUserPagingRepo with PagingRepo<Photo> {
  final String uid;

  PhotosUserPagingRepo({required this.uid});

  @override
  Photo parseJSON(Map<String, dynamic> json) {
    return Photo.fromJson(json);
  }

  @override
  String get url {
    return '/users/$uid/photos';
  }
}
