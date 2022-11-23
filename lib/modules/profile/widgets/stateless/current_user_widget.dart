import 'package:flutter/material.dart';
import 'package:social_instagram/modules/profile/widgets/stateless/item_block.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class CurrentUserWidget extends StatelessWidget {
  const CurrentUserWidget({Key? key}) : super(key: key);

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
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: ItemBloc(
                  subtitle: Text(
                    'Chưa đăng nhập',
                    style: AppTextStyle.datimepost,
                  ),
                  leading: const Icon(Icons.person, color: AppColors.white),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.white,
                    size: 14,
                  ),
                  title: const Text(
                    'Login',
                    style: AppTextStyle.caption,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
