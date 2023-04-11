import 'package:flutter/material.dart';
import 'package:social_instagram/themes/app_text_style.dart';

import '../../../themes/app_colors.dart';
import '../../profileUser/widgets/stateless/current_user_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text('Settings', style: AppTextStyle.LoginStyle3),
            ),
            CurrentUserWidget()
          ],
        ),
      ),
    );
  }
}
