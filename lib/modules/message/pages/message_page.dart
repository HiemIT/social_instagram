import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/profileUser/blocs/app_user_bloc.dart';
import 'package:social_instagram/providers/bloc_provider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final AppUserBloc _appUserBloc = AppUserBloc();

  late String uid;
  AppUserBloc? get bloc => BlocProvider.of<AppUserBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: StreamBuilder(
        stream: _appUserBloc.userStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data as User;
            return Center(
              child: Column(
                children: [
                  Text(
                    user.id!,
                  ),
                ],
              ),
            );
          }
          return const Text('No data');
        },
      ),
    );
  }
}
