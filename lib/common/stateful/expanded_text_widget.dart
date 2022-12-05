import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

class ExpandedTextWidget extends StatefulWidget {
  ExpandedTextWidget({Key? key, required this.text, required this.isCmt})
      : super(key: key);
  String text;
  bool isCmt = false;

  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget> {
  String get commentText => widget.text;

  bool get isCmt => widget.isCmt;

  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (commentText.length > 80) {
      firstHalf = commentText.substring(0, 80) + '...';
      secondHalf = commentText.substring(84, commentText.length);
    } else {
      firstHalf = commentText;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (commentText.trim().isEmpty) {
      return const SizedBox();
    }

    if (!isCmt) {
      return Container(
        margin: const EdgeInsets.only(top: 2),
        child: Text(
          commentText,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColors.slate),
          maxLines: 1,
          overflow: TextOverflow.clip,
          softWrap: false,
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.80,
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: secondHalf.isEmpty
            ? Text(
                commentText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: AppColors.white92),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flag ? firstHalf : commentText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: AppColors.white92),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      setState(
                        () {
                          flag = !flag;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        flag
                            ? Text(
                                "Xem thêm",
                                style: AppTextStyle.datimepost,
                              )
                            : Text("Thu gọn", style: AppTextStyle.datimepost),
                        flag
                            ? Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white70,
                              )
                            : Icon(
                                Icons.arrow_drop_up_sharp,
                                color: Colors.white70,
                              ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
