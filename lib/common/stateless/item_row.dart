import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class ItemRow extends StatelessWidget {
  const ItemRow({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
  }) : super(key: key);

  final String avatarUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            avatarUrl,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ).copyWith(
                color: AppColors.white,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ).copyWith(
                color: AppColors.slate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
