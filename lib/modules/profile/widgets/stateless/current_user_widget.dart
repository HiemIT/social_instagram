import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/blocs/app_state_bloc.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/widgets/stateless/item_block.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

import '../../../../providers/bloc_provider.dart';

class CurrentUserWidget extends StatefulWidget {
  const CurrentUserWidget({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  State<CurrentUserWidget> createState() => _CurrentUserWidgetState();
}

class _CurrentUserWidgetState extends State<CurrentUserWidget> {
  // call bloc AppStateBloc
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);

  // StreamBuilder

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
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.only(left: 20, right: 25),
                  childrenPadding: const EdgeInsets.only(left: 25, right: 20),
                  iconColor: Theme.of(context).iconTheme.color,
                  collapsedIconColor: Theme.of(context).iconTheme.color,
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1664575197229-3bbebc281874?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                  ),
                  title: Text(
                    "Y Hiem Kbuor",
                    style: AppTextStyle.caption,
                  ),
                  subtitle: Text(
                    'yhiemk0@gmail.com',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                      leading:
                          const Icon(Icons.person, color: AppColors.white92),
                      title: Text('Trang cá nhân', style: AppTextStyle.caption),
                      onTap: () {},
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ItemBlock(
                      leading:
                          const Icon(Icons.settings, color: AppColors.white92),
                      title: Text('Chỉnh sữa', style: AppTextStyle.caption),
                      onTap: () {},
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ItemBlock(
                      leading:
                          const Icon(Icons.logout, color: AppColors.white92),
                      title: Text('Đăng xuất', style: AppTextStyle.caption),
                      onTap: () {
                        print('logout');
                        _logout();
                      },
                    ),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
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
