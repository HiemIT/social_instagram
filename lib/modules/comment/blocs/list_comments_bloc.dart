import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/modules/comment/models/comment.dart';
import 'package:social_instagram/modules/comment/repo/list_comments_repo.dart';

import '../../../providers/bloc_provider.dart';

class ListCommentsBloc extends BlocBase {
  final ListCommentsRepo _listCmtRepo;

  final _listCmtCtrl = BehaviorSubject<List<Comment>?>();

  Stream<List<Comment>?> get listCmtStream =>
      _listCmtCtrl.stream.map(transformData);

  ListCommentsBloc(this._listCmtRepo);

  List<Comment> transformData(List<Comment>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    var result = <Comment>[];

    for (final cmt in list) {
      result = [cmt, ...result];
    }

    return result;
  }

  Future<void> getComments() async {
    try {
      final res = await _listCmtRepo.getComments();
      if (res != null) {
        _listCmtCtrl.sink.add(res);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _listCmtCtrl.close();
  }
}
