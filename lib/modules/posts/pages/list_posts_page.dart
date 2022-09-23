import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_instagram/modules/dashboard/widgets/post_item.dart';
import 'package:social_instagram/modules/posts/blocs/list_posts_bloc.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/utils/uidata.dart';

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  State<ListPostsPage> createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsBloc();
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postsBloc.add('getPosts');
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*@override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPostsBloc, ListPostsState>(
      bloc: _postsBloc,
      builder: (context, state) {
        final posts = state.posts;
        if (posts != null) {
          return ListView.builder(
            itemBuilder: (_, int index) {
              final item = posts[index];
              return PostItem(
                height: 200,
                url: item.images?.first.url ?? '',
                description: item.description!,
              );
            },
            itemCount: posts.length,
          );
        }

        final error = state.error;
        if (error != null) {
          return Center(
            child: Text(error.toString()),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.darkGray,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.darkGray,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: AppColors.redGoogle,
                shadows: [
                  BoxShadow(
                    color: AppColors.darkGray,
                    offset: new Offset(10.0, 10.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () async {
                  var status = await Permission.camera.status;
                  if (status.isDenied) {
                    await Permission.camera.request();
                  }

                  if (await Permission.contacts.request().isGranted) {}

// You can request multiple permissions at once.
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.location,
                    Permission.storage,
                  ].request();
                  print(statuses[Permission.location]);
                },
                child: ImageIcon(
                  AssetImage(UIData.iconCamera),
                ),
              ),
            ),
          ),
        ],
        title: Container(
          height: 38,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.transparent,
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey.shade500,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              hintText: "Search",
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 6,
        centerTitle: true,
      ),
      body: BlocBuilder<ListPostsBloc, ListPostsState>(
        bloc: _postsBloc,
        builder: (context, state) {
          final posts = state.posts;

          if (posts != null) {
            return ListView.builder(
              itemCount: posts.length ?? 0,
              itemBuilder: (_, int index) {
                final item = posts[index];
                print(item.toJson());
                return PostItem(
                  // height: 200,
                  description: item.description,
                  item: item,
                );
              },
            );
          }
          final error = state.error;
          if (error != null) {
            return Center(
              child: Text(
                error.toString(),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
