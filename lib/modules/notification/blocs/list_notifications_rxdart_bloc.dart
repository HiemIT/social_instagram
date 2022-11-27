import 'package:rxdart/rxdart.dart';
import 'package:social_instagram/modules/notification/models/notify.dart';
import 'package:social_instagram/modules/notification/repos/list_notification.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class ListNotificationRxdartBloc extends BlocBase {
  final _notificationsCtrl = BehaviorSubject<List<Notify>?>();

  Stream<List<Notify>?> get notificationStream => _notificationsCtrl.stream;

  Future<void> getNotifications() async {
    try {
      final res = await ListNotificationRepo().getNotification();

      if (res != null) {
        _notificationsCtrl.sink.add(res);
      }
    } catch (e) {
      _notificationsCtrl.sink.addError("Cannot fetch list posts right now");
    }
  }

  @override
  void dispose() {
    _notificationsCtrl.close();
  }
}
