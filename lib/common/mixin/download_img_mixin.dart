import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:social_instagram/providers/api_provider.dart';
import 'package:overlay_support/overlay_support.dart';

mixin DownloadImgMixinStateful<T extends StatefulWidget> on State {
  final _apiProvider = ApiProvider();
  Future<void> downloadImg(String name, String url) async {
    try {
      final response = await _apiProvider.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: name,
      );

      if (result != null) {
        // user overlay
        showSimpleNotification(
          Text('Downloaded successfully'),
          background: Colors.green,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
