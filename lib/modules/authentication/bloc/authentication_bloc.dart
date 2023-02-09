import 'package:social_instagram/modules/authentication/enum/login_state.dart';
import 'package:social_instagram/modules/authentication/wrapper/models/login_data.dart';
import 'package:social_instagram/modules/authentication/wrapper/service/auth_service.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class AuthenticationBloc extends BlocBase {
  final AuthService auth;

  AuthenticationBloc(this.auth);

  Future<LoginState> _signIn(Future<LoginData?> signInMethod) async {
    try {
      final loginData = await signInMethod;
      if (loginData != null) {
        // return loginData.isNew ? LoginState.newUser : LoginState.success;
        return LoginState.success;
      }
      return LoginState.fail;
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginState> loginWithGmail() async {
    return _signIn(auth.loginWithGmail());
  }

  @override
  void dispose() {}
}
