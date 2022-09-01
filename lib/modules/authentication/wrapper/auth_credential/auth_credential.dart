abstract class AuthCredential {
  final String url;
  const AuthCredential(this.url);

  /// Returns the data for this credential serialized as a map.
  Map<String, dynamic> asMap();

  @override
  String toString() => asMap().toString();
}
