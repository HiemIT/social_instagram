import 'package:flutter/material.dart';
import 'package:social_instagram/models/user.dart';
import 'package:social_instagram/modules/authentication/pages/welcome_page.dart';
import 'package:social_instagram/modules/comment/blocs/comments_bloc.dart';
import 'package:social_instagram/modules/dashboard/pages/dashboard_page.dart';
import 'package:social_instagram/modules/notification/blocs/list_notifications_rxdart_bloc.dart';
import 'package:social_instagram/modules/notification/pages/notification_page.dart';
import 'package:social_instagram/modules/posts/blocs/post_detail_bloc.dart';
import 'package:social_instagram/modules/posts/models/post.dart';
import 'package:social_instagram/modules/posts/pages/create_post_page.dart';
import 'package:social_instagram/modules/posts/pages/post_detail_page.dart';
import 'package:social_instagram/modules/profile/blocs/profile_bloc.dart';
import 'package:social_instagram/modules/setting/blocs/profile_user_bloc.dart';
import 'package:social_instagram/modules/setting/pages/edit_profile_page.dart';
import 'package:social_instagram/providers/bloc_provider.dart';
import 'package:social_instagram/route/route_name.dart';

import '../modules/posts/blocs/list_posts_rxdart_bloc.dart';
import '../modules/profile/pages/profile_user_page.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return _buildRoute(
            settings,
            BlocProvider(
              bloc: ProfileUserBloc()..fetchProfileUser(),
              child: BlocProvider(
                bloc: ListPostsRxDartBloc()..getPosts(),
                child: const DashboardPage(),
              ),
            ),
          );
        }
      case RouteName.profileUserPage:
        final user = settings.arguments;
        if (user is User) {
          return _buildRoute(
            settings,
            BlocProvider(
              bloc: ProfileBloc(user.id!)..getPostByUser(),
              child: BlocProvider(
                bloc: ProfileBloc(user.id!)..getProfileByUser(),
                child: ProfileUserPage(),
              ),
            ),
          );
        }
        return _errorRoute();
      case RouteName.editProfilePage:
        final user = settings.arguments;
        if (user is User) {
          return _buildRoute(
            settings,
            BlocProvider(
              bloc: ProfileBloc(user.id!)..getProfileByUser(),
              child: EditProfilePage(),
            ),
          );
        }
        return _errorRoute();

      case RouteName.createPostPage:
        {
          return _buildRoute(
            settings,
            CreatePostPage(),
          );
        }

      case RouteName.notificationPage:
        final notification = settings.arguments;
        if (notification is String) {
          return _buildRoute(
            settings,
            BlocProvider(
              bloc: ListNotificationRxdartBloc()..getNotifications(),
              child: const NotificationPage(),
            ),
          );
        }
        return _errorRoute();
      case RouteName.postDetailPage:
        // settings.arguments là một đối tượng để truyền vào một đối tượng từ một trang khác vào trang này (đối tượng này có thể là một đối tượng bất kỳ)
        List? arguments = settings.arguments as List;
        Post? post = arguments[0] as Post?;
        String uid = arguments[1];
        if (post is Post) {
          return _buildRoute(
            settings,
            BlocProvider(
              bloc: PostDetailBloc(post.id!),
              child: BlocProvider(
                bloc: CommentBloc(post.id!),
                child: PostDetailPage(post: post, id: uid),
              ),
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route unAuthorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(
          settings,
          // const LoginPage()
          const WelcomePage(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coming soon'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
