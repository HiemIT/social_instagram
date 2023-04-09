import 'package:flutter/material.dart';

class MySliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double preferredHeight;
  final Widget child;

  MySliverAppBarDelegate({
    required this.preferredHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => preferredHeight;

  @override
  double get minExtent => preferredHeight;

  @override
  bool shouldRebuild(covariant MySliverAppBarDelegate oldDelegate) {
    return preferredHeight != oldDelegate.preferredHeight ||
        child != oldDelegate.child;
  }
}
