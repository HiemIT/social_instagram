import 'package:social_instagram/providers/api_provider.dart';

abstract class DeleteRepo {
  final _apiProvider = ApiProvider();

  String get url;

  Future<bool> delete({String? id}) async {
    // nếu id được truyền vào thì sẽ thêm vào url để thực hiện xóa còn không thì sẽ thực hiện xóa theo url được truyền vào từ các repo khác kế thừa từ DeleteRepo
    final realURL = id == null ? url : url.replaceFirst(':id', id);
    final res = await _apiProvider.delete(realURL);

    return res.statusCode == 200;
  }
}
