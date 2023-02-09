import '../../../resource/delete_repo.dart';

class DeleteCmtRepo extends DeleteRepo {
  final String postId;
  final String? cmtId;

  DeleteCmtRepo(this.postId, {this.cmtId});

  @override
  String get url => '/posts/$postId/comments/$cmtId';
}
