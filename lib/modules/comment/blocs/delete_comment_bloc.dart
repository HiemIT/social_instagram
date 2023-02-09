import '../repo/delete_cmt_repo.dart';

class DeleteCommentBloc {
  final DeleteCmtRepo _repo;

  DeleteCommentBloc(this._repo);

  Future<bool> deleteComment(String postId, String cmtId) async {
    try {
      return DeleteCmtRepo(postId, cmtId: cmtId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
