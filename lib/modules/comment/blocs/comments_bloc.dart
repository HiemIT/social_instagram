import 'package:social_instagram/modules/comment/blocs/create_comment_bloc.dart';
import 'package:social_instagram/modules/comment/blocs/delete_comment_bloc.dart';
import 'package:social_instagram/modules/comment/blocs/list_comments_bloc.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/modules/comment/repo/create_comment_repo.dart';
import 'package:social_instagram/modules/comment/repo/list_comments_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

import '../repo/delete_cmt_repo.dart';

class CommentBloc extends BlocBase {
  final String postId;
  final ListCommentsBloc _commentsBloc;
  final CreateCommentBloc _createCmtBloc;
  final DeleteCommentBloc _deleteCmtBloc;

  Stream<List<Comment>?> get listCmtStream => _commentsBloc.listCmtStream;

  CommentBloc(this.postId)
      : _commentsBloc = ListCommentsBloc(ListCommentsRepo(postId)),
        _deleteCmtBloc = DeleteCommentBloc(DeleteCmtRepo(postId)),
        _createCmtBloc = CreateCommentBloc(CreateCommentRepo(postId));

  Future<void> getComments() async => _commentsBloc.getComments();

  Future<void> writeCmt(String content) async {
    final res = await _createCmtBloc.createCmt(content);
    if (res) {
      _commentsBloc.getComments();
    }
  }

  Future<void> deleteCmt(String postId, String cmtId) async {
    final res = await _deleteCmtBloc.deleteComment(postId, cmtId);
    if (res) {
      _commentsBloc.getComments();
    }
  }

  @override
  void dispose() {}
}
