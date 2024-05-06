import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medications/generated/l10n.dart';

class NoMedicationWidget extends StatelessWidget {
  final String title;
  const NoMedicationWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/medication.svg',
          width: 60,
          height: 60,
        ),
        SizedBox(height: 12.h),
        Text(
          S.of(context).noMedicine,
          style: theme.textTheme.textStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.textStyle.color,
          ),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 72.w),
          child: Text(
            S.of(context).titleMedicationsWillBeStoredHere(title),
            style: theme.textTheme.textStyle.copyWith(
              color: CupertinoColors.systemGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
