// import 'package:social_instagram/modules/notification/models/notify.dart';
//
// import '../../../providers/api_provider.dart';
//
// class ListNotificationRepo {
//   final apiProvider = ApiProvider();
//
//   Future<List<Notify>?> getNotification() async {
//     try {
//       final response = await apiProvider.get("/notifications");
//
//       if (response.statusCode != 200) {
//         return null;
//       }
//       List data = response.data['data'];
//       return data.map((json) => Notify.fromJson(json)).toList();
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
