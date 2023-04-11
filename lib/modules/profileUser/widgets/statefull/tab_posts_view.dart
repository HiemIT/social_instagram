import 'package:flutter/material.dart';

import '../../../../providers/bloc_provider.dart';
import '../../../posts/models/post.dart';
import '../../../posts/widgets/stateless/post_item.dart';
import '../../blocs/profile_user_bloc.dart';

class TabPostsView extends StatefulWidget {
  const TabPostsView({Key? key}) : super(key: key);

  @override
  State<TabPostsView> createState() => _TabPostsViewState();
}

class _TabPostsViewState extends State<TabPostsView> {
  ProfileUserBloc? get currentUser => BlocProvider.of<ProfileUserBloc>(context);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>?>(
      stream: currentUser?.postStream,
      builder: (context, snapshot) {
        return Container(
          child: snapshot.data == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  controller: ScrollController(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return PostItem(
                      post: snapshot.data![index],
                      isProfile: true,
                    );
                  },
                ),
        );
      },
    );
  }
}

Widget _build() {
  return Container();
}
