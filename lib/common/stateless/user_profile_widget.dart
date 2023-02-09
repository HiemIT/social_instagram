import 'package:flutter/material.dart';
import 'package:social_instagram/common/stateless/custom_cache_network_image.dart';
import 'package:social_instagram/common/stateless/item_total.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomCacheNetworkImage(
                      imageUrl: user.imgUrl,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.displayName,
                  style: AppTextStyle.LoginStyle5.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ItemTotal(
                  title: "Photos",
                  total: user.totalPhotos.toString(),
                ),
                const SizedBox(
                  width: 20,
                ),
                ItemTotal(
                    title: "Followers", total: user.totalFollowers.toString()),
                const SizedBox(
                  width: 20,
                ),
                ItemTotal(
                  title: "Following",
                  total: user.totalFollowings.toString(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          if (user.instagramUsername != null) ...[
            const SizedBox(height: 5),
            Wrap(
              children: [
                const Text('Instagram: ', style: AppTextStyle.LoginStyle5),
                GestureDetector(
                  onTap: () async {
                    Uri url = Uri.parse(
                        'https://www.instagram.com/${user.instagramUsername}/');
                    try {
                      if (await canLaunchUrl(url)) {}
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: Text(
                    '${user.instagramUsername}',
                    style: const TextStyle(color: Color(0xff3498db)),
                  ),
                )
              ],
            ),
          ],
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
