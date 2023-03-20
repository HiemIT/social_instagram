import 'package:flutter/material.dart';

class TabPhotoView extends StatefulWidget {
  const TabPhotoView({Key? key}) : super(key: key);

  @override
  State<TabPhotoView> createState() => _TabPhotoViewState();
}

class _TabPhotoViewState extends State<TabPhotoView> {
  @override
  Widget build(BuildContext context) {
    return _build();
    // StreamBuilder<List<Post>?>(
    //     stream: bloc!.postStream,
    //     builder: (context, snapshot) {
    //       return Container(
    //         child: snapshot.data == null
    //             ? const Center(child: CircularProgressIndicator())
    //             : ListView.builder(
    //                 controller: ScrollController(),
    //                 itemCount: snapshot.data!.length,
    //                 itemBuilder: (context, index) {
    //                   return PostItem(
    //                     uid: snapshot.data![index].id,
    //                     post: snapshot.data![index],
    //                   );
    //                 },
    //               ),
    //       );
    //     },
    //   );
    // }
  }
}

Widget _build() {
  return Container();
}
