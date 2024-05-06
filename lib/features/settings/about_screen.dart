import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/base_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);

    return BaseScreen(
      navigationBar: CupertinoNavigationBar(
        middle: Text(S.of(context).aboutApplication),
        border: null,
      ),
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 53.h),
              SvgPicture.asset(
                'assets/icons/icon.svg',
                width: 172.r,
                height: 172.r,
              ),
              SizedBox(height: 16.h),
              Text(
                'Medications',
                style: theme.textTheme.textStyle.copyWith(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              FutureBuilder(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  } else {
                    if (snapshot.hasData) {
                      return Text(
                        S.of(context).versionVersion(snapshot.data!.version),
                        style: theme.textTheme.textStyle.copyWith(
                          fontSize: 15.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                      );
                    } else {
                      return Text(
                        S.of(context).errorCouldntFetchCurrentVersion,
                        style: theme.textTheme.textStyle.copyWith(
                          fontSize: 15.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
