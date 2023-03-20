class DetailNotification {
  final String modelId;

  DetailNotification({required this.modelId});

  String get url => '/posts/$modelId';
}
