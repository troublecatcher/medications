import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medications/app/init/init_di.dart';
import 'package:medications/app/init/init_hive.dart';
import 'package:medications/app/service/notification_manager.dart';
import 'package:medications/app/service/remote_config_service.dart';
import 'package:medications/app/theme.dart';
import 'package:medications/features/medications/model/medication/medication.dart';
import 'package:medications/features/schedule/model/schedule/schedule.dart';
import 'package:medications/features/medications/controller/medication_list_cubit.dart';
import 'package:medications/features/medications/view/medications_screen.dart';
import 'package:medications/features/schedule/controller/schedule_list_cubit.dart';
import 'package:medications/features/schedule/view/schedule_screen.dart';
import 'package:medications/features/settings/darkmode_cubit.dart';
import 'package:medications/features/settings/locale_cubit.dart';
import 'package:medications/features/settings/promotion_screen.dart';
import 'package:medications/features/settings/settings_screen.dart';
import 'package:medications/generated/l10n.dart';

late Box<Medication> medicationBox;
late Box<Schedule> scheduleBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  await initHive();
  await GetIt.I<NotificationManager>().init();

  final sp = GetIt.I<SharedPreferences>();
  final locale = sp.getString('locale');
  if (locale == null) {
    final systemLocale = Platform.localeName.split('_').first;
    final defaultLocale = systemLocale == 'ru' ? 'ru' : 'en';
    sp.setString('locale', defaultLocale);
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DarkmodeCubit()),
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => MedicationListCubit()),
        BlocProvider(create: (_) => ScheduleListCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<DarkmodeCubit, bool>(
            builder: (context, isDarkTheme) {
          return BlocBuilder<LocaleCubit, String>(
            builder: (context, locale) => MaterialApp(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: Locale(locale),
              theme: ThemeData(platform: TargetPlatform.iOS),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                final promotion = GetIt.I<RemoteConfigService>().promotion;
                return CupertinoTheme(
                  data: isDarkTheme ? darkTheme : lightTheme,
                  child: promotion != null && promotion.isNotEmpty
                      ? const PromotionScreen()
                      : child!,
                );
              },
              onGenerateRoute: (RouteSettings settings) {
                return MaterialWithModalsPageRoute(
                  builder: (context) => Scaffold(
                    body: CupertinoTabScaffold(
                      tabBar: CupertinoTabBar(
                        backgroundColor:
                            CupertinoTheme.of(context).brightness ==
                                    Brightness.light
                                ? CupertinoTheme.of(context).barBackgroundColor
                                : const Color.fromRGBO(28, 28, 30, 1),
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: const Icon(CupertinoIcons.clock_fill),
                            label: S.of(context).schedule,
                          ),
                          BottomNavigationBarItem(
                            icon:
                                SvgPicture.asset('assets/icons/medication.svg'),
                            activeIcon: SvgPicture.asset(
                              'assets/icons/medication.svg',
                              colorFilter: ColorFilter.mode(
                                CupertinoTheme.of(context).primaryColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            label: S.of(context).medication,
                          ),
                          BottomNavigationBarItem(
                            icon: const Icon(CupertinoIcons.settings),
                            label: S.of(context).settings,
                          ),
                        ],
                      ),
                      tabBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return const ScheduleScreen();
                        } else if (index == 1) {
                          return const MedicationsScreen();
                        } else {
                          return const SettingsScreen();
                        }
                      },
                    ),
                  ),
                  settings: settings,
                );
              },
            ),
          );
        });
      },
    );
  }
}
