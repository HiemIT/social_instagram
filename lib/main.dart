import 'package:flutter/material.dart';
import 'package:social_instagram/src/app.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   String _message = 'You are not sign in';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Firebase Login'),
//         ),
//         body: FutureBuilder(
//             future: _initialization,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }
//
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return Center(
//                   child: TextButton(
//                     child: Text("Login"),
//                     onPressed: signInWithGoogle,
//                   ),
//                 );
//               }
//               return CircularProgressIndicator();
//             }));
//   }
//
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // print get token
//     print(credential.accessToken.toString());
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
// }
