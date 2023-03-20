import 'dart:async';

import 'package:social_instagram/blocs/paging_data_bloc.dart';
import 'package:social_instagram/common/blocs/app_even_bloc.dart';
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

  late final StreamSubscription<BlocEvent> _subReadNotify;
  final ListNotificationPagingRepo _repo;

  ListNotificationRxdartBloc() : _repo = ListNotificationPagingRepo() {
    _subReadNotify = AppEventBloc().listenEvent(
      eventName: EventName.readNotifiCation,
      handler: _readNotification,
    );
  }

  Future<void> getNotifications() async {
    return getData();
  }

  void _readNotification(BlocEvent event) {
    if (event.value is! Notify) return;

    final notify = event.value as Notify;
    dataValue!
        .where((element) => element.id == notify.id)
        .forEach((element) => element.isRead = 1);

    dataSubject.add(dataValue!);
  }

  @override
  dispose() {
    _subReadNotify.cancel();
    super.dispose();
  }

  @override
  PagingRepo<Notify> get dataRepo => _repo;
}
