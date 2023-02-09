import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profile/blocs/update_profile_bloc.dart';
import 'package:social_instagram/modules/setting/widgets/edit_avatar.dart';
import 'package:social_instagram/themes/app_text_style.dart';

import '../../../providers/bloc_provider.dart';
import '../../../themes/app_colors.dart';
import '../../profile/blocs/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileBloc? get _profileBloc => BlocProvider.of<ProfileBloc>(context);

  late final TextEditingController _firstNameController =
      TextEditingController();
  late final FocusNode _firstNameFocus;

  late final TextEditingController _lastNameController =
      TextEditingController();
  late final FocusNode _lastNameFocus;
  late final TextEditingController _emailController = TextEditingController();
  late final FocusNode _emailFocus;

  @override
  void initState() {
    super.initState();
    _profileBloc!.profileByUserStream.listen((event) {
      _firstNameController.text = event!.firstName ?? '';
      _lastNameController.text = event.lastName ?? '';
      _emailController.text = event.email ?? '';
    });
    _firstNameFocus = FocusNode();
    _lastNameFocus = FocusNode();
    _emailFocus = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        elevation: 0,
        actions: [
          //  button text done
          TextButton(
            onPressed: updateProfile,
            child: const Text(
              'Done',
              style: TextStyle(color: AppColors.redSend),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text('Edit Profile', style: AppTextStyle.LoginStyle3),
              ),
              //  Avatar image
              StreamBuilder<User?>(
                stream: _profileBloc!.profileByUserStream,
                builder: (context, snapshot) {
                  var user = snapshot.data;
                  if (snapshot.data != null) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          // CircleAvatar(
                          //   radius: 82,
                          //   backgroundImage: NetworkImage('${user!.imgUrl}'),
                          // ),
                          // const SizedBox(height: 5),
                          // //  button text change profile photo
                          // TextButton(
                          //   onPressed: () {},
                          //   child: const Text(
                          //     'Change Profile Photo',
                          //     style: TextStyle(color: AppColors.redSend),
                          //   ),
                          // ),
                          EditAvatar(),
                          const SizedBox(height: 10),
                          // show UserName
                          Column(
                            children: [
                              TextField(
                                focusNode: _firstNameFocus,
                                style: AppTextStyle.caption,
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'Your first name',
                                  hintStyle: AppTextStyle.caption,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                focusNode: _lastNameFocus,
                                style: AppTextStyle.caption,
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Your last name',
                                  hintStyle: AppTextStyle.caption,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                focusNode: _emailFocus,
                                style: AppTextStyle.caption,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Your email',
                                  hintStyle: AppTextStyle.caption,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.redSend,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
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

  Future<void> updateProfile() async {
    try {
      final response = await UpdateProfileBloc().updateProfile(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text);

      //  If the response is true, the user will be redirected to the profile page and call function profileBloc to update the profile and save it in local storage
      if (response) {
        // quay lai trang profile nhung muon load lai du lieu moi
        Navigator.pop(context);
        _profileBloc!.getProfileByUser();
        return;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
