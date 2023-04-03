import 'package:social_instagram/providers/api_provider.dart';

abstract class UpdateRepo {
  final _apiProvider = ApiProvider();

  String get url;

  Future<bool> update({String? id, Map<String, dynamic>? body}) async {
    final realURL = id == null ? url : url.replaceFirst(':id', id);
    final res = await _apiProvider.put(realURL, data: body);

    return res.statusCode == 200;
  }
}
