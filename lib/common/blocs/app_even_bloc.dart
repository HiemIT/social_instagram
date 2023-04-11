import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

enum EventName {
  updatePost,
  deletePost,
  likePostDetail,
  unLikePostDetail,
  readNotifiCation,
  updateProfile,
}

class BlocEvent {
  final EventName _eventName;
  final dynamic _value;

  const BlocEvent(this._eventName, [this._value]);

  EventName get name => _eventName;

  dynamic get value => _value;
}

class AppEventBloc extends BlocBase {
  AppEventBloc._internal();

  // Singleton
  static final _instance = AppEventBloc._internal();

  factory AppEventBloc() => _instance;

  final _eventController = PublishSubject<BlocEvent>();

  // ban event
  Function(BlocEvent) get emitEvent => _eventController.sink.add;

  // listenEvent để lắng nghe event và xử lý dữ liệu trả về cho UI khi có sự thay đổi dữ liệu
  StreamSubscription<BlocEvent> listenEvent({
    required EventName eventName,
    required Function(BlocEvent) handler,
  }) {
    return _eventController.stream
        .where((evt) => evt.name == eventName)
        .listen(handler);
  }

  // eventName: refreshListPost,
  // call api refresh list post
  //

  StreamSubscription<BlocEvent> listenManyEvents({
    required List<EventName> listEventName,
    required Function(BlocEvent) handler,
  }) {
    return _eventController.stream
        .where((evt) => listEventName.contains(evt.name))
        .listen(handler);
  }

  @override
  void dispose() {
    _eventController.close();
  }
}
