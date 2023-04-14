import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:social_instagram/providers/api_provider.dart';

mixin DownloadImgMixinStateful<T extends StatefulWidget> on State<T> {
  final _apiProvider = ApiProvider();
  bool isFlag = false;
  Future<bool> downloadImg(String name, String url) async {
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

      if (result == null) {
        return isFlag;
      }

      return !isFlag;
    } catch (e) {
      return isFlag;
    }
  }
}
