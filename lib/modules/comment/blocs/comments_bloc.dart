import 'package:social_instagram/modules/comment/blocs/list_comments_bloc.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/modules/comment/repo/list_comments_repo.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class CommentBloc extends BlocBase {
  final String postId;
  final ListCommentsBloc _commentsBloc;

  Stream<List<Comment>?> get listCmtStream => _commentsBloc.listCmtStream;

  CommentBloc(this.postId)
      : _commentsBloc = ListCommentsBloc(ListCommentsRepo(postId));

  Future<void> getComments() async => _commentsBloc.getComments();

  @override
  void dispose() {}
}
