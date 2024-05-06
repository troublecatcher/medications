import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medications/features/medications/controller/update_medication.dart';
import 'package:medications/features/medications/model/medication/medication.dart';
import 'package:medications/features/medications/view/widget/no_medication_widget.dart';
import 'package:medications/features/medications/view/widget/medication_widget.dart';
import 'package:medications/generated/l10n.dart';

class CompletedMedications extends StatelessWidget {
  final List<Medication> completedList;
  const CompletedMedications({
    super.key,
    required this.completedList,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (completedList.isNotEmpty) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: completedList.length,
            itemBuilder: (context, index) {
              final medication = completedList[index];
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
          return NoMedicationWidget(title: S.of(context).completed);
        }
      },
    );
  }
}
