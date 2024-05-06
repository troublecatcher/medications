import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medications/app/service/firebase_options.dart';
import 'package:medications/app/service/notification_manager.dart';
import 'package:medications/app/service/remote_config_service.dart';

Future<void> initDI() async {
  final getIt = GetIt.I;
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  final notificationManager = NotificationManager();
  getIt.registerLazySingleton<NotificationManager>(() => notificationManager);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await remoteConfig.fetchAndActivate();
  final remoteConfigService = RemoteConfigService(remoteConfig);
  getIt.registerSingleton<RemoteConfigService>(remoteConfigService);
}
