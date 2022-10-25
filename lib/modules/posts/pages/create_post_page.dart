import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_instagram/common/stateless/loading_hide_keyboard.dart';
import 'package:social_instagram/themes/app_colors.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late final TextEditingController _desCtrl;
  late final FocusNode _focusNodeDes;
  bool isLoading = false;

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
          padding: const EdgeInsets.fromLTRB(5, 16, 5, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
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
                          hintStyle: TextStyle(color: Colors.white38),
                          filled: true,
                          border: InputBorder.none,
                          fillColor: AppColors.darkGray,
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
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPost() async {}
}

/*
* 1 Tao post thanh cong: chi can des, chi can co hinh, des + hinh
* 2 k cho tao post: co up hinh chua, chua co dien des
* */
