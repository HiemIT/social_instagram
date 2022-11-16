class StringUtils {
  String formatTimeAgo(DateTime time) {
    final date = DateTime.parse(time.toIso8601String());
    final difference = DateTime.now().difference(date);

    if (difference.inDays > 0) {
      if (difference.inDays > 1) {
        return '${date.day}/${date.month}/${date.year}';
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
  }
}
