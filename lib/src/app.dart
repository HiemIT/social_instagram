import 'package:flutter/material.dart';
import 'package:social_instagram/modules/posts/pages/list_posts_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPostsPage(),
    );
  }
}
