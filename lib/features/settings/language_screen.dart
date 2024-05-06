import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medications/features/settings/locale_cubit.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/base_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      navigationBar: CupertinoNavigationBar(
        middle: Text(S.of(context).language),
        border: null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: BlocBuilder<LocaleCubit, String>(
          builder: (context, state) {
            return CupertinoListSection.insetGrouped(
              hasLeading: false,
              children: [
                CupertinoListTile(
                  title: const Text('Русский'),
                  trailing: state == 'ru'
                      ? const Icon(CupertinoIcons.check_mark)
                      : null,
                  onTap: () {
                    context.read<LocaleCubit>().set('ru');
                  },
                ),
                CupertinoListTile(
                  title: const Text('English'),
                  trailing: state == 'en'
                      ? const Icon(CupertinoIcons.check_mark)
                      : null,
                  onTap: () {
                    context.read<LocaleCubit>().set('en');
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
