import '../../../resource/paging_repo.dart';
import '../models/notify.dart';

class ListNotificationPagingRepo extends PagingRepo<Notify> {
  @override
  Notify parseJSON(Map<String, dynamic> json) {
    return Notify.fromJson(json);
  }

  @override
  String get url => '/notifications';
}
