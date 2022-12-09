import 'package:flutter/material.dart';
import 'package:social_instagram/modules/notification/pages/notification_page.dart';
import 'package:social_instagram/modules/posts/pages/list_post_paging_page.dart';
import 'package:social_instagram/modules/setting/pages/setting_page.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/uidata.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> _children = [
    // const ListPostsPage(),
    const ListPostPagingPage(),
    const NotificationPage(),
    const SettingPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage(UIData.iconStream),
          //   ),
          //   label: "Home 2",
          // ),
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
