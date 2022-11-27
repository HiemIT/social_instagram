import 'package:flutter/material.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class ItemTotal extends StatelessWidget {
  const ItemTotal({Key? key, required this.title, required this.total})
      : super(key: key);
  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          FittedBox(
            child: Text(
              total,
              style: AppTextStyle.caption
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: AppTextStyle.caption.copyWith(color: AppColors.slate),
          ),
        ],
      ),
    );
  }
}
