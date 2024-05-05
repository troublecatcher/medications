import 'package:flutter/cupertino.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final ObstructingPreferredSizeWidget? navigationBar;
  final bool? bottom;
  final Color? backgroundColor;
  const BaseScreen({
    super.key,
    required this.child,
    this.navigationBar,
    this.bottom,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: navigationBar,
      child: SafeArea(
        bottom: bottom ?? true,
        child: child,
      ),
    );
  }
}
