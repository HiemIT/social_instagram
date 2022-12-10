import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/modules/notification/models/notify.dart';
import 'package:social_instagram/modules/notification/repos/list_notification_paging_repo.dart';
import 'package:social_instagram/resource/paging_repo.dart';

// class ListNotificationRxdartBloc extends BlocBase {
//   final _notificationsCtrl = BehaviorSubject<List<Notify>?>();
//
//   Stream<List<Notify>?> get notificationStream => _notificationsCtrl.stream;
//
//   Future<void> getNotifications() async {
//     try {
//       final res = await ListNotificationRepo().getNotification();
//
//       if (res != null) {
//         _notificationsCtrl.sink.add(res);
//       }
//     } catch (e) {
//       _notificationsCtrl.sink.addError("Cannot fetch list posts right now");
//     }
//   }
//
//   @override
//   void dispose() {
//     _notificationsCtrl.close();
//   }
// }

class ListNotificationRxdartBloc extends PagingDataBehaviorBloc<Notify> {
  Stream<List<Notify>?> get notificationStream => dataStream;

  final ListNotificationPagingRepo _repo;

  ListNotificationRxdartBloc() : _repo = ListNotificationPagingRepo() {}

  Future<void> getNotifications() async {
    return getData();
  }

  @override
  PagingRepo<Notify> get dataRepo => _repo;
}
