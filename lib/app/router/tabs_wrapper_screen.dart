import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:template/app/router/router.dart';
import 'package:template/shared/mediactions_icon.dart';

@RoutePage()
class TabWrapperScreen extends StatelessWidget {
  const TabWrapperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      animationDuration: Duration.zero,
      routes: const [
        ScheduleRoute(),
        MedicationsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return CupertinoTabBar(
          activeColor: CupertinoTheme.of(context).primaryColor,
          currentIndex: tabsRouter.activeIndex,
          onTap: (value) {
            tabsRouter.setActiveIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: MIcon(child: CupertinoIcons.time_solid, active: false),
              activeIcon: MIcon(child: CupertinoIcons.time_solid, active: true),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: MIcon(
                child: 'assets/icons/medication.svg',
                active: false,
              ),
              activeIcon: MIcon(
                child: 'assets/icons/medication.svg',
                active: true,
              ),
              label: 'Medication',
            ),
            BottomNavigationBarItem(
              icon: MIcon(child: CupertinoIcons.settings, active: false),
              activeIcon: MIcon(child: CupertinoIcons.settings, active: true),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
