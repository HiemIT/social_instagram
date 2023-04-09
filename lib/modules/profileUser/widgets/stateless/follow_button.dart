import 'package:flutter/material.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

class FollowButton extends StatelessWidget {
  final bool isFollowing;
  final Function onTap;

  FollowButton({required this.isFollowing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isFollowing ? AppColors.redSend : AppColors.redGoogle,
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            transform: GradientRotation(3.14 / 2),
            colors: [
              isFollowing ? AppColors.grey : AppColors.redGoogle,
              isFollowing ? AppColors.grey : AppColors.redSend,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            isFollowing ? 'Following' : 'Follower',
            textDirection: TextDirection.rtl,
            style: AppTextStyle.datimepost.copyWith(),
          ),
        ),
      ),
    );
  }
}
