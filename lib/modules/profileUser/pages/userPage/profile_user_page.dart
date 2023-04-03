import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';

class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({Key? key, user, required this.profileUser})
      : super(key: key);

  final User profileUser;

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
