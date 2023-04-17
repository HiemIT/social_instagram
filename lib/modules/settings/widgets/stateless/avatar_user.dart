import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/stateful/upload/image_upload_item.dart';
import '../../../../models/user.dart';
import '../../../../providers/api_provider.dart';
import '../../../../themes/app_colors.dart';

class AvatarUser extends StatefulWidget {
  const AvatarUser({super.key, required this.user});
  final User? user;

  @override
  State<AvatarUser> createState() => _AvatarUserState();
}

class _AvatarUserState extends State<AvatarUser> {
  final apiProvider = ApiProvider();

  List<ImageUploadItem> _lstImageParam = <ImageUploadItem>[];

  int? _imgWidth;
  int? _imgHeight;

  List<Asset> get _selectedAssets => _lstImageParam
      .where((e) => e.asset != null)
      .map((e) => e.asset!)
      .toList();
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final screenWith = sizeScreen.width;

    return buildColumView();
  }

  Widget buildColumView() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('${widget.user?.imgUrl}'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            chooseAndUploadImage();
          },
          child: Text(
            'Change Avatar',
            style: TextStyle(color: AppColors.redGoogle),
          ),
        ),
      ],
    );
  }

  Future<void> chooseAndUploadImage() async {
    List<Asset> resultList = <Asset>[];

    var localListImg = <ImageUploadItem>[];

    final currentStatus = await Permission.photos.status;

    if (currentStatus == PermissionStatus.denied ||
        currentStatus == PermissionStatus.restricted) {
      await Permission.photos.request();
    } else if (currentStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: _selectedAssets,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          //backgroundColor: "#${Colors.black.value.toRadixString(16)}",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Dofhunt",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      if (resultList.isEmpty) return;
    } catch (e) {
      print(e);
    }
  }
}
