import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DismissibleBin extends StatelessWidget {
  const DismissibleBin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(
            CupertinoIcons.delete_solid,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
