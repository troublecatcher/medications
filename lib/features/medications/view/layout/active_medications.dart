import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medications/features/medications/controller/update_medication.dart';
import 'package:medications/features/medications/model/medication/medication.dart';
import 'package:medications/features/medications/view/widget/no_medication_widget.dart';
import 'package:medications/features/medications/view/widget/medication_widget.dart';
import 'package:medications/generated/l10n.dart';

class ActiveMedications extends StatelessWidget {
  final List<Medication> activeList;
  const ActiveMedications({
    super.key,
    required this.activeList,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (activeList.isNotEmpty) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeList.length,
            itemBuilder: (context, index) {
              final medication = activeList[index];
              return MedicationWidget(
                index: index,
                medication: medication,
                onTap: () async {
                  await updateMedication(context, medication);
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
          );
        } else {
          return NoMedicationWidget(title: S.of(context).active);
        }
      },
    );
  }
}
