import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final ObstructingPreferredSizeWidget? navigationBar;
  final bool? bottom;
  const BaseScreen(
      {super.key, required this.child, this.navigationBar, this.bottom});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: SafeArea(
        bottom: bottom ?? true,
        child: child,
      ),
    );
  }
}
