import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/notification/pages/notification_page.dart';
import 'package:social_instagram/modules/posts/pages/list_post_paging_page.dart';
import 'package:social_instagram/modules/profileUser/blocs/app_user_bloc.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/uiData.dart';

import '../../../providers/bloc_provider.dart';
import '../../settings/pages/setting_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final appUserBloc = BlocProvider.of<AppUserBloc>(context);
    final List<Widget> _children = [
      const ListPostPagingPage(),
      StreamBuilder<User?>(
          stream: appUserBloc!.userStream,
          builder: (context, snapshot) {
            // if snapshot null
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // if snapshot has data
            final user = snapshot.data;
            return NotificationPage(uid: user!.id);
          }),
      const SettingView(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.blackRussian,
        currentIndex: _index,
        onTap: onTabTapped,
        iconSize: 36,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.redMedium,
        unselectedItemColor: AppColors.slate,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(UIData.iconHome),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(UIData.iconNotifications),
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(UIData.iconProfile),
            ),
            label: "Profiles",
          ),
        ],
      ),
      body: _children[_index],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
}
