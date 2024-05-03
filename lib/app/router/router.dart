import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/init/remote_config_service.dart';
import 'package:template/app/router/tabs_wrapper_screen.dart';
import 'package:template/features/medications/presentation/medications_screen.dart';
import 'package:template/features/medications/presentation/new_medication_bottom_sheet.dart';
import 'package:template/features/settings/privacy_policy_screen.dart';
import 'package:template/features/settings/promotion_screen.dart';
import 'package:template/features/settings/settings_screen.dart';
import 'package:template/features/settings/terms_of_use_screen.dart';
import 'package:template/features/schedule/schedule_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes {
    final promotion = GetIt.I<RemoteConfigService>().promotion;
    final showPromotion = promotion != null && promotion.isNotEmpty;
    return [
      AutoRoute(page: TabWrapperRoute.page, initial: !showPromotion, children: [
        AutoRoute(page: ScheduleRoute.page),
        AutoRoute(page: MedicationsRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ]),
      AutoRoute(page: NewMedicationBottomSheetRoute.page),
      AutoRoute(page: PromotionRoute.page, initial: showPromotion),
      AutoRoute(page: PrivacyPolicyRoute.page),
      AutoRoute(page: TermsOfUseRoute.page),
    ];
  }
}
