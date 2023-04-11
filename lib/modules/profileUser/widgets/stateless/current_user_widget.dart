import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/themes/app_text_style.dart';

import '../../../../blocs/app_state_bloc.dart';
import '../../../../providers/bloc_provider.dart';
import '../../../../route/route_name.dart';
import '../../../../themes/app_colors.dart';
import '../../../posts/widgets/stateless/confirm_dialog.dart';
import '../../blocs/app_user_bloc.dart';
import 'item_block.dart';

class CurrentUserWidget extends StatefulWidget {
  const CurrentUserWidget({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<CurrentUserWidget> createState() => _CurrentUserWidgetState();
}

class _CurrentUserWidgetState extends State<CurrentUserWidget> {
  // call bloc AppStateBloc
  AppUserBloc? get profileBloc => BlocProvider.of<AppUserBloc>(context);
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account', style: AppTextStyle.LoginStyle2),
        const SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent),
                child: StreamBuilder<User?>(
                    stream: profileBloc?.userStream,
                    builder: (context, snapshot) {
                      var user = snapshot.data;
                      print('user: $user');
                      return ExpansionTile(
                        tilePadding: const EdgeInsets.only(left: 20, right: 25),
                        childrenPadding:
                            const EdgeInsets.only(left: 25, right: 20),
                        iconColor: Theme.of(context).iconTheme.color,
                        collapsedIconColor: Theme.of(context).iconTheme.color,
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.grey,
                          backgroundImage: user?.imgUrl != null
                              ? CachedNetworkImageProvider(user?.imgUrl ?? '')
                              : null,
                          child: user?.imgUrl == null
                              ? const Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                )
                              : null,
                        ),
                        title: Text(
                          user?.displayName ?? '',
                          style: AppTextStyle.caption,
                        ),
                        subtitle: Text(
                          '${user?.email ?? ''}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.grey,
                                  ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                          size: 14,
                        ),
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ItemBlock(
                            leading: const Icon(Icons.person,
                                color: AppColors.white92),
                            title: Text('Trang cá nhân',
                                style: AppTextStyle.caption),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.myProfilePage,
                                  arguments: user?.id);
                            },
                          ),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemBlock(
                            leading: const Icon(Icons.settings,
                                color: AppColors.white92),
                            title:
                                Text('Chỉnh sữa', style: AppTextStyle.caption),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.editProfilePage,
                                  arguments: user);
                            },
                          ),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ItemBlock(
                            leading: const Icon(Icons.logout,
                                color: AppColors.white92),
                            title:
                                Text('Đăng xuất', style: AppTextStyle.caption),
                            onTap: () {
                              // print('logout');
                              // _logout();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmDialog(
                                      title: 'Đăng xuất',
                                      message:
                                          'Bạn có chắc chắn muốn đăng xuất không?',
                                      onYesPressed: () {
                                        _logout();
                                        Navigator.pop(context);
                                      },
                                      onNoPressed: () {
                                        Navigator.pop(context);
                                      },
                                    );
                                  });
                            },
                          ),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _logout() async {
    await appStateBloc?.logout();
  }
}
