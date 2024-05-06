import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medications/features/medications/controller/update_medication.dart';
import 'package:medications/features/medications/model/medication/medication.dart';
import 'package:medications/features/medications/view/widget/no_medication_widget.dart';
import 'package:medications/features/medications/view/widget/medication_widget.dart';
import 'package:medications/generated/l10n.dart';

class AllMedications extends StatelessWidget {
  final List<Medication> activeList;
  final List<Medication> completedList;
  final List<Medication> fullList;
  const AllMedications({
    Key? key,
    required this.activeList,
    required this.completedList,
    required this.fullList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (activeList.isEmpty && completedList.isEmpty) {
          return NoMedicationWidget(title: S.of(context).added);
        } else {
          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMedicationList(context, S.of(context).active, activeList),
              const SizedBox(height: 16),
              _buildMedicationList(
                  context, S.of(context).completed, completedList),
            ],
          );
        }
      },
    );
  }

  Widget _buildMedicationList(
      BuildContext context, String title, List<Medication> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final medication = list[index];
            return MedicationWidget(
              index: index,
              medication: medication,
              onTap: () async {
                await updateMedication(context, medication);
              },
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
        ),
      ],
    );
  }
}
