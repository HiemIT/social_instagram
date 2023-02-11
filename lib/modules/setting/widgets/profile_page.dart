import 'package:flutter/material.dart';
import 'package:social_instagram/route/route_name.dart';

import '../../../common/stateless/user_profile_widget.dart';
import '../../../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("EDIT"),
                value: 'profile_page.dart',
              )
            ],
            onSelected: (value) {
              switch (value) {
                case "EDIT":
                  showModalBottomSheet(
                      context: context, builder: (context) => Wrap());
              }
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: UserProfileWidget(
                user: user,
              ),
            )
          ];
        },
        body: DefaultTabController(
          length: 2,
          child: Column(),
        ),
      ),
    );
  }
}

void navigateToProfilePage(BuildContext context, User? user) {
  if (user != null) {
    Navigator.pushNamed(context, RouteName.profileUserPage, arguments: user);
  }
}
