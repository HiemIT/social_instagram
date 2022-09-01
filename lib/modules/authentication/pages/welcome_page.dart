import 'package:flutter/material.dart';
import 'package:social_instagram/blocs/app_state_bloc.dart';
import 'package:social_instagram/modules/authentication/bloc/authentication_bloc.dart';
import 'package:social_instagram/modules/authentication/enum/login_state.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppStateBloc? get appStateBloc => BlocProvider.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Login'),
          onPressed: () async {
            final authBloc = BlocProvider.of<AuthenticationBloc>(context);
            final loginState = await authBloc!.loginWithGmail();

            if (loginState == LoginState.success) {
              final appStateBloc = BlocProvider.of<AppStateBloc>(context);
              appStateBloc?.changeAppState(AppState.authorized);
            }
          },
        ),
      ),
    );
  }

  void _changeAppState() {
    appStateBloc!.changeAppState(AppState.authorized);
  }
}
