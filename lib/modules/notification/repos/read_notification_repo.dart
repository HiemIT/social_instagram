import 'package:social_instagram/resource/delete_repo.dart';

class ReadNotificationRepo extends DeleteRepo {
  final String notifyId;

  ReadNotificationRepo(this.notifyId);

  @override
  String get url => '/notifications/$notifyId';
}
