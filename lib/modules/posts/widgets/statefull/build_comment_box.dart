import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_instagram/modules/comment/blocs/comments_bloc.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class BuildCommentBox extends StatefulWidget {
  const BuildCommentBox({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildCommentBox> createState() => _BuildCommentBoxState();
}

class _BuildCommentBoxState extends State<BuildCommentBox> {
  late final TextEditingController _cmtCtrl;
  late final FocusNode _focusNodeDes;

  CommentBloc? get commentBloc => BlocProvider.of<CommentBloc>(context);

  @override
  void initState() {
    super.initState();

    _cmtCtrl = TextEditingController();
    _focusNodeDes = FocusNode();
    commentBloc!.getComments();
  }

  @override
  void dispose() {
    _cmtCtrl.dispose();
    _focusNodeDes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 85.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -2),
              blurRadius: 6.0,
            ),
          ],
          color: AppColors.secondary,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: height, //when it reach the max it will use scroll
            maxWidth: width,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                maxLength: 200,
                style: const TextStyle(color: Colors.white),
                controller: _cmtCtrl,
                focusNode: _focusNodeDes,
                decoration: InputDecoration(
                  hintText: 'Viết bình luận...',
                  hintStyle: TextStyle(color: AppColors.blurWhite),
                  counterStyle: AppTextStyle.datimepost
                      .copyWith(color: AppColors.blurWhite),
                  filled: true,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: AppColors.slate),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: AppColors.slate),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  fillColor: AppColors.slate,
                  suffixIcon: Container(
                    margin: EdgeInsets.only(right: 4.0),
                    width: 60.0,
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(CircleBorder())),
                      onPressed: () => _writeCmt(),
                      child: Icon(
                        Icons.send,
                        size: 25.0,
                        color: AppColors.redSend,
                      ),
                    ),
                  ),
                ),
                minLines: 1,
                maxLines: null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(300),
                ],
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _writeCmt() async {
    try {
      final res = await commentBloc!.writeCmt(_cmtCtrl.text);
      _cmtCtrl.clear();
      return res;
    } catch (e) {
      debugPrint('Cmt err');
    }
  }
}
