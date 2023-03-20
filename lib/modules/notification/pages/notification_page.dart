import 'package:flutter/material.dart';
import 'package:social_instagram/common/mixin/scroll_page_mixin.dart';
import 'package:social_instagram/modules/notification/blocs/list_notifications_rxdart_bloc.dart';
import 'package:social_instagram/modules/notification/widgets/statefull/card_notification.dart';
import 'package:social_instagram/modules/posts/widgets/stateless/activity_indicator.dart';
import 'package:social_instagram/themes/app_colors.dart';
import 'package:social_instagram/themes/app_text_style.dart';

import "../models/notify.dart";

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, this.uid}) : super(key: key);
  final String? uid;
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with ScrollPageMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late final _scrollCtrl = ScrollController();
  final _notificationBloc = ListNotificationRxdartBloc();
  String? get uid => widget.uid;
  // NotificationsBloc? get bloc => BlocProvider.of<NotificationsBloc>(context);

  @override
  void initState() {
    super.initState();
    _notificationBloc.getNotifications();
  }

  @override
  void dispose() {
    _notificationBloc.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppColors.white,
        backgroundColor: AppColors.dark,
        strokeWidth: 1.0,
        onRefresh: () async {
          await _notificationBloc.getNotifications();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollCtrl,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                'Notification',
                style: AppTextStyle.LoginStyle3,
              ),
            ),
            StreamBuilder<List<Notify>?>(
              stream: _notificationBloc.notificationStream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const SliverFillRemaining(
                    child: ActivityIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(snapshot.hasError.toString()),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final itemNotify = snapshot.data![index];
                      return CardNotification(
                        notify: itemNotify,
                        id: uid ?? "",
                        context: context,
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void loadMoreData() => _notificationBloc.getData();

  @override
  ScrollController get scrollController => _scrollCtrl;
}
