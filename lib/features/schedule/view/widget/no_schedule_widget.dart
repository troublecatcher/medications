import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medications/generated/l10n.dart';

class NoScheduleWidget extends StatelessWidget {
  const NoScheduleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          CupertinoIcons.calendar,
          size: 60,
          color: Color.fromRGBO(142, 142, 147, 1),
        ),
        SizedBox(height: 12.h),
        Text(
          S.of(context).theDayIsEmpty,
          style: theme.textTheme.textStyle.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.textStyle.color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 72.w),
          child: Text(
            S.of(context).medicationSchedulesWillAppearHere,
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
