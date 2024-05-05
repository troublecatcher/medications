import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final lightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  barBackgroundColor: const Color.fromRGBO(242, 242, 247, 1),
  scaffoldBackgroundColor: const Color.fromRGBO(242, 242, 247, 1),
  primaryContrastingColor: CupertinoColors.white,
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontSize: 17.sp,
      color: CupertinoColors.black,
    ),
  ),
);

final darkTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  barBackgroundColor: CupertinoColors.black,
  scaffoldBackgroundColor: CupertinoColors.black,
  primaryContrastingColor: const Color.fromRGBO(28, 28, 30, 1),
  textTheme: CupertinoTextThemeData(
    textStyle: TextStyle(
      fontSize: 17.sp,
      color: CupertinoColors.white,
    ),
  ),
);
