import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/utils/uiData.dart';

import '../../../../common/mixin/scroll_page_mixin.dart';
import '../../../../providers/bloc_provider.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';
import '../../blocs/profile_user_bloc.dart';
import '../../widgets/statefull/user_post_view.dart';
import '../../widgets/stateless/follow_button.dart';
import '../../widgets/stateless/photos_grid_view.dart';

class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({Key? key}) : super(key: key);

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

List<Widget> item = [];

class _ProfileUserPageState extends State<ProfileUserPage>
    with SingleTickerProviderStateMixin, ScrollPageMixin {
  late final _scrollCtrl = ScrollController();
  late TabController _tabController = TabController(vsync: this, length: 2);
  @override
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
    _tabController.dispose();
  }

  ProfileUserBloc? get currentUser => BlocProvider.of<ProfileUserBloc>(context);

  @override
  Widget build(BuildContext context) {
    //
    final size = MediaQuery.of(context).size;
    final sizeWidth = size.width;
    final sizeHeigh = size.height;
    double top = 0;

    return DefaultTabController(
      animationDuration: Duration(milliseconds: 300),
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.dark,
        body: SafeArea(
          child: StreamBuilder<User?>(
            stream: currentUser?.detailUserStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
              final user = snapshot.data;
              return NestedScrollView(
                controller: _scrollCtrl,
                physics: const BouncingScrollPhysics(
                    parent: ClampingScrollPhysics()),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: (sizeHeigh) * 0.3,
                      backgroundColor: AppColors.dark,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, cons) {
                          top = cons.biggest.height;
                          return FlexibleSpaceBar(
                            centerTitle: true,
                            collapseMode: CollapseMode.pin,
                            title: AnimatedOpacity(
                              duration: Duration(microseconds: 3000),
                              opacity: top >= 130.0 ? 1.0 : 0.0,
                              child: Row(children: [
                                SizedBox(width: 12),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      CachedNetworkImageProvider(user!.imgUrl),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  snapshot.data?.displayName ?? '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data?.imgUrl ?? "",
                                  fit: BoxFit.cover,
                                ),
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            stretchModes: [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                              StretchMode.fadeTitle,
                            ],
                          );
                        },
                      ),
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: currentUser?.getPhotos,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsetsDirectional.all(8),
                        color: AppColors.dark,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${user?.totalPhotos}',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Post',
                                          style: AppTextStyle.caption.copyWith(
                                              color: AppColors.slate,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${user?.totalFollowings ?? '0'}',
                                          style: TextStyle(
                                            color: AppColors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Following',
                                          style: AppTextStyle.caption.copyWith(
                                              color: AppColors.slate,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${user?.totalFollowers ?? '0'}',
                                          style: TextStyle(
                                              color: AppColors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Follower',
                                          style: AppTextStyle.caption.copyWith(
                                              color: AppColors.slate,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        print('Follow');
                                      },
                                      child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.redGoogle,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: LinearGradient(
                                              transform:
                                                  GradientRotation(3.14 / 2),
                                              colors: [
                                                AppColors.redGoogle,
                                                AppColors.redSend,
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomRight,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.white
                                                    .withOpacity(0.1),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: FollowButton(
                                              isFollowing: user!.followedUser,
                                              onTap: () {},
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          controller: _tabController,
                          labelColor: AppColors.redSend,
                          unselectedLabelColor: AppColors.slate,
                          indicatorColor: AppColors.darkBlue,
                          indicatorPadding:
                              EdgeInsets.symmetric(horizontal: 16),
                          labelPadding: EdgeInsets.zero,
                          dividerColor: AppColors.slate,
                          tabs: [
                            Tab(
                              icon: ImageIcon(
                                AssetImage(UIData.iconCombinedShape),
                              ),
                            ),
                            Tab(
                              icon: ImageIcon(
                                AssetImage(UIData.iconPicture),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SliverList(
                    //   delegate: SliverChildBuilderDelegate(
                    //     (_, int index) {
                    //       return Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           TabBar(
                    //             controller: _tabController,
                    //             labelColor: AppColors.black,
                    //             unselectedLabelColor: AppColors.slate,
                    //             indicatorColor: AppColors.blur,
                    //             indicatorWeight: 4,
                    //             indicatorPadding:
                    //                 EdgeInsets.symmetric(horizontal: 16),
                    //             labelPadding: EdgeInsets.zero,
                    //             tabs: [
                    //               Tab(
                    //                 icon: ImageIcon(
                    //                   AssetImage(UIData.iconCombinedShape),
                    //                 ),
                    //               ),
                    //               Tab(
                    //                 icon: ImageIcon(
                    //                   AssetImage(UIData.iconPicture),
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       );
                    //     },
                    //     childCount: 1,
                    //   ),
                    // ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  physics: BouncingScrollPhysics(
                    parent: NeverScrollableScrollPhysics(),
                  ), // to disable TabBar scrolling
                  children: <Widget>[
                    UserPostView(currentUser: currentUser!),
                    PhotosGridView(currentUser: currentUser),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void loadMoreData() => currentUser?.getPhotos();

  @override
  ScrollController get scrollController => _scrollCtrl;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.darkBlue,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
