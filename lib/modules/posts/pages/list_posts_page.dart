import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/blocs/list_posts_rxdart_bloc.dart';
import 'package:social_instagram/modules/posts/widgets/stateless/activity_indicator.dart';
import 'package:social_instagram/modules/posts/widgets/stateless/post_item_remake.dart';
import 'package:social_instagram/route/route_name.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/uidata.dart';
import '../models/post.dart';

class ListPostsPage extends StatefulWidget {
  const ListPostsPage({Key? key}) : super(key: key);

  @override
  State<ListPostsPage> createState() => _ListPostsPageState();
}

class _ListPostsPageState extends State<ListPostsPage> {
  final _postsBloc = ListPostsRxDartBloc();
  late final ScrollController _scrollCtrl;
  final _controller = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _postsBloc.getPosts();
    _scrollCtrl = ScrollController();
    // khi vào trang này thì sẽ lấy dữ liệu từ server về
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppColors.white,
        backgroundColor: AppColors.dark,
        strokeWidth: 1.0,
        onRefresh: () async {
          return Future.delayed(Duration(seconds: 1), () {
            _postsBloc.getPosts();
          });
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollCtrl,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.darkGray,
              snap: true,
              floating: true,
              elevation: 0.0,
              forceElevated: true,
              title: Container(
                height: 38,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.blueGrey.withOpacity(0.12),
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.white92,
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
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.createPostPage);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: AppColors.redSend,
                      shadows: [
                        BoxShadow(
                          color: AppColors.darkGray,
                          offset: new Offset(10.0, 10.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ImageIcon(
                      AssetImage(UIData.iconCamera),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoSliverRefreshControl(
              onRefresh: _postsBloc.getPosts,
            ),
            StreamBuilder<List<Post>?>(
                stream: _postsBloc.postsStream,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SliverFillRemaining(
                      child: ActivityIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text('Something went wrong'),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return PostItemRemake(
                          post: snapshot.data![index],
                        );
                      },
                      childCount: snapshot.data?.length ?? 0,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
