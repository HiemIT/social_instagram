import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/pages/profile_page.dart';
import 'package:social_instagram/modules/profile/widgets/stateless/item_block.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class CurrentUserWidget extends StatelessWidget {
  const CurrentUserWidget({Key? key, required this.user}) : super(key: key);

  final User user;

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
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: ItemBlock(
                  leading: const Icon(Icons.person, color: AppColors.white),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 14,
                  ),
                  title: const Text(
                    'Trang cá nhân',
                    style: AppTextStyle.caption,
                  ),
                  onTap: () {
                    navigateToProfilePage(context, user);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
