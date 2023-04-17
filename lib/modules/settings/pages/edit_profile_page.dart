import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/settings/widgets/stateless/avatar_user.dart';

import '../../../providers/bloc_provider.dart';
import '../../../themes/app_colors.dart';
import '../../../themes/app_text_style.dart';
import '../../profileUser/blocs/app_user_bloc.dart';
import '../widgets/stateless/item_user_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  AppUserBloc? get profileBloc => BlocProvider.of<AppUserBloc>(context);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.dark,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text('Edit Profile', style: AppTextStyle.LoginStyle3),
                ),
                ...[
                  StreamBuilder<User?>(
                    builder: (context, snapshot) {
                      return Container(
                        width: size.width - 2,
                        child: Column(
                          children: [
                            AvatarUser(
                              user: snapshot.data,
                            ),
                            const SizedBox(height: 10),
                            ItemUserWidget(),
                          ],
                        ),
                      );
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
