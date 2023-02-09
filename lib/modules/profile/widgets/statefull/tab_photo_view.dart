import 'package:flutter/material.dart';
import 'package:social_instagram/modules/profile/blocs/profile_bloc.dart';

import '../../../../providers/bloc_provider.dart';
import '../../../posts/models/post.dart';
import '../../../posts/widgets/stateless/post_item.dart';

class TabPhotoView extends StatefulWidget {
  const TabPhotoView({Key? key}) : super(key: key);

  @override
  State<TabPhotoView> createState() => _TabPhotoViewState();
}

class _TabPhotoViewState extends State<TabPhotoView> {
  ProfileBloc? get bloc => BlocProvider.of<ProfileBloc>(context);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>?>(
      stream: bloc!.postStream,
      builder: (context, snapshot) {
        return Container(
          child: snapshot.data == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: ScrollController(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return PostItem(
                      uid: snapshot.data![index].id,
                      post: snapshot.data![index],
                    );
                  },
                ),
        );
      },
    );
  }
}
