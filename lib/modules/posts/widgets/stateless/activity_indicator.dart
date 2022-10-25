import 'package:flutter/cupertino.dart';

class ActivityIndicator extends StatelessWidget {
  const ActivityIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CupertinoActivityIndicator(
              radius: 12,
              color: CupertinoColors.white,
              animating: true,
            ),
          ),
          Text(
            "Loading...",
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
