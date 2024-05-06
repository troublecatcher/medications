import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/features/medications/controller/delete_medication.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/medications/controller/medication_list_cubit.dart';
import 'package:template/features/settings/locale_cubit.dart';
import 'package:template/shared/dismissible_bin.dart';

class MedicationWidget extends StatelessWidget {
  final int index;
  final Medication medication;
  final Function() onTap;

  const MedicationWidget({
    super.key,
    required this.index,
    required this.medication,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, String>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).primaryContrastingColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Dismissible(
              background: const DismissibleBin(),
              direction: DismissDirection.endToStart,
              onDismissed: (_) async {
                await deleteMedication(context, medication);
              },
              key: UniqueKey(),
              child: CupertinoListTile.notched(
                onTap: onTap,
                leadingSize: 60,
                leading: Image.asset(
                  'assets/imgs/${medication.iconIndex}.png',
                  width: 42.r,
                  height: 42.r,
                ),
                title: Text(medication.name),
                subtitle: Text(state == 'ru'
                    ? medication.measure.titleRU
                    : medication.measure.titleEN),
                trailing: const CupertinoListTileChevron(),
              ),
            ),
          ),
        );
      },
    );
  }
}
