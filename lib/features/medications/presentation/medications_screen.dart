import 'package:auto_route/auto_route.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/shared/base_screen.dart';

@RoutePage()
class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Medications'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Add'),
              onPressed: () {},
            ),
            border: null,
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomSlidingSegmentedControl(
                isStretch: true,
                innerPadding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                thumbDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: CupertinoTheme.of(context).primaryColor,
                ),
                initialValue: value,
                children: {
                  0: Text(
                    'All',
                    style: TextStyle(
                      color: value == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  1: Text(
                    'Active',
                    style: TextStyle(
                      color: value == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  2: Text(
                    'Completed',
                    style: TextStyle(
                      color: value == 2 ? Colors.white : Colors.black,
                    ),
                  ),
                },
                onValueChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
              ),
            ),
          ),
          // if()
        ],
      ),
    );
  }
}
