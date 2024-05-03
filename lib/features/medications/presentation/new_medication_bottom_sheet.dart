import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/shared/base_screen.dart';

@RoutePage()
class NewMedicationBottomSheetScreen extends StatelessWidget {
  const NewMedicationBottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add medication'),
      ),
      child: Container(),
    ));
  }
}
