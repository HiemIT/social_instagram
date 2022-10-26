import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_instagram/common/stateless/loading_hide_keyboard.dart';
import 'package:social_instagram/modules/posts/blocs/create_post_bloc.dart';
import 'package:social_instagram/themes/app_colors.dart';

import '../../../common/stateful/upload/image_upload_group.dart';
import '../../../common/stateful/upload/image_upload_item.dart';
import '../../../common/stateful/upload/upload_group_value.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final TextEditingController _desCtrl;
  late final FocusNode _focusNodeDes;
  bool isLoading = false;

  UploadGroupValue _currentGroupUploadValue =
      const UploadGroupValue(<ImageUploadItem>[]);

  bool get _completeUploadImage =>
      _currentGroupUploadValue.state == UploadGroupState.finished;

  @override
  void initState() {
    super.initState();

    _desCtrl = TextEditingController();
    _focusNodeDes = FocusNode();
  }

  @override
  void dispose() {
    _desCtrl.dispose();
    _focusNodeDes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGray,
      appBar: AppBar(
        title: const Text('Create post page'),
        backgroundColor: AppColors.darkGray,
      ),
      body: LoadingHideKeyboard(
        isLoading: isLoading,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: _desCtrl,
                          focusNode: _focusNodeDes,
                          decoration: const InputDecoration(
                            hintText: 'Type description here...',
                            hintStyle: TextStyle(color: AppColors.blurWhite),
                            filled: true,
                            border: InputBorder.none,
                            fillColor: AppColors.slate,
                          ),
                          autocorrect: false,
                          minLines: 5,
                          maxLines: 15,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),
                          ],
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ImageUploadGroup(
                        isFullGrid: false,
                        onValueChanged: (UploadGroupValue value) {
                          setState(() {
                            _currentGroupUploadValue = value;
                          });
                        },
                        listImages: const [],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 42),
              SafeArea(child: buildButtonUpload()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonUpload() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary:
              _completeUploadImage ? AppColors.deepSkyBlue : AppColors.grey,
        ),
        onPressed: _completeUploadImage ? createPost : null,
        child: const Text('Create Post',
            style: TextStyle(fontSize: 16, color: AppColors.white)),
      ),
    );
  }

  Future<void> createPost() async {
    try {
      final res = await CreatePostBloc()
          .createPost(_desCtrl.text, _currentGroupUploadValue.uploadedIds);

      if (res) {
        Navigator.pop(context);
        return;
      }
    } catch (e) {
      //  show alert error
    }
  }
}

/*
* 1 Tao post thanh cong: chi can des, chi can co hinh, des + hinh
* 2 k cho tao post: co up hinh chua, chua co dien des
* */
