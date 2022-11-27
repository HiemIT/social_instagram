import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/blocs/profile_bloc.dart';
import 'package:social_instagram/modules/profile/widgets/stateless/current_user_widget.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _profileBloc.getProfile();
  }

  @override
  void dispose() {
    _profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text('Setting', style: AppTextStyle.LoginStyle3),
              ),
              StreamBuilder<User?>(
                stream: _profileBloc.profileStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CurrentUserWidget(user: snapshot.data!);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
