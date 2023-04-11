import 'package:flutter/material.dart';

import '../../../../providers/bloc_provider.dart';
import '../../blocs/profile_user_bloc.dart';
import '../stateless/photos_grid_view.dart';

class TabPhotosView extends StatefulWidget {
  const TabPhotosView({Key? key}) : super(key: key);

  @override
  State<TabPhotosView> createState() => _TabPhotosViewState();
}

class _TabPhotosViewState extends State<TabPhotosView> {
  ProfileUserBloc? get currentUser => BlocProvider.of<ProfileUserBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotosGridView(
        currentUser: currentUser,
      ),
    );
  }
}
