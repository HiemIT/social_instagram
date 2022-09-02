import 'package:flutter/material.dart';
import 'package:social_instagram/modules/authentication/pages/welcome_page.dart';
import 'package:social_instagram/modules/posts/pages/list_posts_page.dart';

class Routes {
  static Route authorizedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return _buildRoute(
            settings,
            ListPostsPage(),
          );
        }
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
