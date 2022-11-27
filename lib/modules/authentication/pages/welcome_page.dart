import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_instagram/blocs/app_state_bloc.dart';
import 'package:social_instagram/modules/authentication/bloc/authentication_bloc.dart';
import 'package:social_instagram/modules/authentication/enum/login_state.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/themes/app_text_style.dart';
import 'package:social_instagram/utils/uidata.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: TextButton(
  //         child: const Text('Login'),
  //         onPressed: () async {
  //           final authBloc = BlocProvider.of<AuthenticationBloc>(context);
  //           final loginState = await authBloc!.loginWithGmail();
  //
  //           if (loginState == LoginState.success) {
  //             // final appStateBloc = BlocProvider.of<AppStateBloc>(context);
  //             // appStateBloc?.changeAppState(AppState.authorized);
  //             _changeAppState();
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(UIData.imgBackgroundWelcome),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                  opacity: 0.6,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Find new",
                            style: GoogleFonts.aBeeZee(
                                textStyle: AppTextStyle.LoginStyle1),
                          ),
                          Text(
                            "friends nearby",
                            style: GoogleFonts.aBeeZee(
                                textStyle: AppTextStyle.LoginStyle1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "With milions of users all over the world, we gives you the ability to connect with people no matter where you are.",
                          style: GoogleFonts.aBeeZee(
                            textStyle: AppTextStyle.LoginStyle2,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(22),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xffF78361),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(22),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Or log in with",
                                style: TextStyle(
                                    color: Color(0xff4E586E), fontSize: 13),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print("Facebook");
                                    },
                                    icon: Image.asset(UIData.iconFacebook),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print("Twitter");
                                    },
                                    icon: Image.asset(UIData.iconTwitter),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      print("Google");
                                      _loginGoogle();
                                      // signInWithGoogle();
                                    },
                                    icon: Image.asset(UIData.iconGoogle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginGoogle() async {
    final loginSuccess = LoginState.success;
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final loginState = await authBloc!.loginWithGmail();

    if (loginState == loginSuccess) {
      _changeAppState();
      // final appStateBloc = BlocProvider.of<AppStateBloc>(context);
      // appStateBloc?.changeAppState(AppState.authorized);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print("credential: $credential");
    // print token
    print("accessToken: ${googleAuth?.accessToken}");

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void _changeAppState() {
    appStateBloc!.changeAppState(AppState.authorized);
  }
}
