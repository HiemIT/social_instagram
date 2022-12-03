import 'package:social_instagram/modules/posts/repos/like_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class LikeBloc extends BlocBase {
  final CanLikeRepo likeRepo;

  LikeBloc(this.likeRepo);

  Future<bool> like(String id) => likeRepo.like(id);

  Future<bool> unlike(String id) => likeRepo.unlike(id);

  @override
  void dispose() {}
}
