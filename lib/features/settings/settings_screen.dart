import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Builder(builder: (ctx) {
          return CupertinoButton(
            child: const Text('123'),
            onPressed: () {},
          );
        }),
      ),
    );
  }
}
