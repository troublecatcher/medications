import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MIcon extends StatelessWidget {
  final dynamic child;
  final bool active;
  const MIcon({super.key, required this.child, required this.active});

  @override
  Widget build(BuildContext context) {
    final color =
        active ? CupertinoTheme.of(context).primaryColor : Colors.black;
    if (child is String) {
      return SvgPicture.asset(
        child,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      );
    } else if (child is IconData) {
      return Icon(child, color: color);
    } else {
      return const SizedBox.shrink();
    }
  }
}
