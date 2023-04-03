import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/user_profile_widget.dart';
// import 'package:social_instagram/modules/profile/blocs/profile_bloc.dart';
import 'package:social_instagram/modules/profile/widgets/statefull/tab_photo_view.dart';
import 'package:social_instagram/modules/profileUser/blocs/app_user_bloc.dart';
import 'package:social_instagram/utils/uiData.dart';

import '../../../../models/user.dart';
import '../../../../providers/bloc_provider.dart';
import '../../../../themes/app_colors.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late final _scrollCtrl = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // call profile bloc
  AppUserBloc? get profileBloc => BlocProvider.of<AppUserBloc>(context);
  final AppUserBloc _appUserBloc = AppUserBloc();
  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
        // call post bloc
        BlocProvider.of<AppUserBloc>(context);
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _appUserBloc.userStream,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
              color: AppColors.dark,
              child: const Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Container(
              color: AppColors.dark,
              child: Center(child: Text(snapshot.error.toString())));
        }

        final user = snapshot.data as User;
        List<Map> tabs = [];
        if (user.totalPhotos != 0) {
          tabs.add({
            'title': UIData.iconCombinedShape,
            'tab': TabPhotoView(),
          });
        }
        if (user.totalPhotos != 0) {
          tabs.add({
            'title': UIData.iconPicture,
            'tab': Container(),
          });
        }
        return Scaffold(
          backgroundColor: AppColors.dark,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.dark,
            title: Text('${user.displayName}'),
            centerTitle: true,
          ),
          body: NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollCtrl,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: UserProfileWidget(
                    user: user,
                  ),
                ),
              ];
            },
            body: DefaultTabController(
              length: tabs.length,
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: tabs
                        .map((tab) =>
                            Tab(icon: ImageIcon(AssetImage(tab['title']))))
                        .toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: tabs
                          .map(
                            (tab) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: tab["tab"],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
