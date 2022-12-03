import 'package:intl/intl.dart';

class DateFormatUntil {
  static String dateFormat(DateTime createAt, {String? locale}) {
    final date = DateTime.parse(createAt.toIso8601String());
    final difference = DateTime.now().difference(date);

    if (locale == null || locale.isEmpty) {
      locale = 'vi';
    }

    if (difference.inDays > 0) {
      if (difference.inDays > 1) {
        return DateFormat.d().format(createAt) + ' ' + 'ngày';
      } else if (difference.inDays > 30) {
        return DateFormat.M().format(createAt) + ' ' + 'Tuần';
      } else {
        return 'Hôm qua';
      }
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
    // return DateFormat.M().format(createAt);
  }
}
