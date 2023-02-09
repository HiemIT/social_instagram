import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/user_profile_widget.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/blocs/profile_bloc.dart';
import 'package:social_instagram/modules/profile/widgets/statefull/tab_photo_view.dart';
import 'package:social_instagram/utils/uiData.dart';

import '../../../providers/bloc_provider.dart';
import '../../../themes/app_colors.dart';

class ProfileUserPage extends StatefulWidget {
  const ProfileUserPage({Key? key}) : super(key: key);

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage> {
  late final _scrollCtrl = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // call profile bloc
  ProfileBloc? get profileBloc => BlocProvider.of<ProfileBloc>(context);

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
        // call post bloc
        BlocProvider.of<ProfileBloc>(context)?.postStream;
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
    return StreamBuilder<User?>(
        stream: profileBloc?.profileByUserStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final user = snapshot.data!;
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
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
        });
  }
}
