import 'package:flutter/material.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class ItemBlock extends StatelessWidget {
  const ItemBlock(
      {Key? key,
      required this.leading,
      required this.title,
      this.trailing,
      this.onTap,
      this.subtitle})
      : super(key: key);
  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                leading,
                const SizedBox(
                  width: 10,
                ),
                title,
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: AppTextStyle.datimepost,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
