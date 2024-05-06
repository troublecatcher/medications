import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:medications/features/settings/about_screen.dart';
import 'package:medications/features/settings/darkmode_cubit.dart';
import 'package:medications/features/settings/language_screen.dart';
import 'package:medications/features/settings/privacy_policy_screen.dart';
import 'package:medications/features/settings/question_screen.dart';
import 'package:medications/features/settings/terms_of_use_screen.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/base_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool shareable = true;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            transitionBetweenRoutes: false,
            largeTitle: Text(S.of(context).settings),
            border: null,
            stretch: true,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/appearance.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).appearance),
                      trailing: BlocBuilder<DarkmodeCubit, bool>(
                        builder: (context, state) =>
                            CupertinoSlidingSegmentedControl(
                          groupValue: state,
                          children: {
                            false: Text(S.of(context).light),
                            true: Text(S.of(context).dark),
                          },
                          onValueChanged: (value) =>
                              context.read<DarkmodeCubit>().set(value!),
                        ),
                      ),
                    ),
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/language.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).language),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LanguageScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/question.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).askAQuestion),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QuestionScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/privacy.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).privacyPolicy),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      ),
                    ),
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/terms.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).termsOfUse),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TermsOfUseScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  children: [
                    Builder(builder: (ctx) {
                      return CupertinoListTile(
                        leading: SvgPicture.asset(
                          'assets/icons/share.svg',
                          width: 30,
                          height: 30,
                        ),
                        title: Text(S.of(context).shareApp),
                        trailing: const CupertinoListTileChevron(),
                        onTap: () async {
                          if (shareable) {
                            shareable = false;
                            final box = ctx.findRenderObject() as RenderBox?;
                            await Share.share(
                              'Check out this Medications app!',
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size,
                            ).whenComplete(() => shareable = true);
                          }
                        },
                      );
                    }),
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/rate.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).rateTheApp),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () async {
                        final InAppReview inAppReview = InAppReview.instance;
                        if (await inAppReview.isAvailable()) {
                          inAppReview.requestReview();
                        }
                      },
                    ),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  children: [
                    CupertinoListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/about.svg',
                        width: 30,
                        height: 30,
                      ),
                      title: Text(S.of(context).aboutTheApp),
                      trailing: const CupertinoListTileChevron(),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
