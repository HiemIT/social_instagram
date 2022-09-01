import 'auth_credential.dart';

/// An [AuthCredential] for authenticating via gmail.com.
class GmailAuthCredential extends AuthCredential {
  /// The Gmail access token.
  final String? accessToken;
  static const String _url = 'https://api.dofhunt.200lab.io/v1/auth/gmail';

  const GmailAuthCredential({this.accessToken}) : super(_url);

  @override
  Map<String, String?> asMap() {
    return {'gmail_token': accessToken};
  }
}
