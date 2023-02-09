import 'package:social_instagram/modules/comment/repo/react_cmt_repo.dart';

class ReactCmtBloc {
  final ReactCmtRepo _repo;

  ReactCmtBloc(this._repo);

  Future<bool> unReactCmt(String cmtId) async {
    final res = await _repo.unReact(cmtId);
    return res;
  }

  Future<bool> reactCmt(String cmtId, int type) async {
    final res = await _repo.react(cmtId, type);
    return res;
  }
}
