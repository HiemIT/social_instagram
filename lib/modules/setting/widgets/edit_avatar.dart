import 'dart:io';

import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';

class EditAvatar extends StatefulWidget {
  @override
  _EditAvatarState createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  File? _image;

  Future getImage() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: _image != null ? FileImage(_image!) : null,
            radius: 50.0,
          ),
          TextButton(
            onPressed: getImage,
            child: const Text(
              'Change Profile Photo',
              style: TextStyle(color: AppColors.redSend),
            ),
          ),
        ],
      ),
    );
  }
}
