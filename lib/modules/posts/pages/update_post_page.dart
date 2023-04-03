import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_instagram/modules/posts/blocs/post_detail_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';

import '../../../common/stateful/upload/image_upload_group.dart';
import '../../../common/stateful/upload/image_upload_item.dart';
import '../../../common/stateful/upload/upload_group_value.dart';
import '../../../common/stateless/loading_hide_keyboard.dart';
import '../../../providers/bloc_provider.dart';
import '../../../themes/app_colors.dart';
import '../models/post_update.dart';

class UpdatePostPage extends StatefulWidget {
  const UpdatePostPage({Key? key, required this.post}) : super(key: key);

  final Post? post;

  @override
  _UpdatePostPageState createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  PostDetailBloc? get bloc => BlocProvider.of<PostDetailBloc>(context);

  Post get post => widget.post!;
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
    bloc?.getPost();
    _desCtrl = TextEditingController();
    _desCtrl.text = post.description ?? '';
    _focusNodeDes = FocusNode();

    _currentGroupUploadValue = UploadGroupValue(
      post.images!.map((e) => ImageUploadItem.fromPicture(e)).toList(),
    );

    // _updatePost();
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
        title: const Text('Update post page'),
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
          backgroundColor:
              _completeUploadImage ? AppColors.deepSkyBlue : AppColors.grey,
        ),
        onPressed: _completeUploadImage ? _updatePost : null,
        child: const Text('Update Post',
            style: TextStyle(fontSize: 16, color: AppColors.white)),
      ),
    );
  }

  // Future<void> _updatePost() async {
  //   try {
  //     // get value for parameter body
  //     final PostUpdate data = PostUpdate(
  //       description: _desCtrl.text,
  //     );
  //     final res = await UpdatePostBloc().updatePost(post.id!, body: data);

  //     if (res) {
  //       Navigator.popUntil(context, (route) => route.settings.name == '/');
  //     }
  //   } catch (e) {}
  // } Replace to use bloc

  Future<void> _updatePost() async {
    final PostUpdate data = PostUpdate(
      id: post.id,
      description: _desCtrl.text,
    );
    await bloc!
        .updatePost(data)
        .then(
          (value) => Navigator.popUntil(
              context, (route) => route.settings.name == '/'),
        )
        .onError(
          (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
              ),
            ),
          ),
        );
  }
}
