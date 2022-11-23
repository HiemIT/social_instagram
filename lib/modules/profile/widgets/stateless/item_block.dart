import 'package:flutter/material.dart';

class ItemBloc extends StatelessWidget {
  const ItemBloc(
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
  final Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
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
                  subtitle!,
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: 10,
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
