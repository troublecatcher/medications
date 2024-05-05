import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/generated/l10n.dart';

class IntakeTimeBottomSheet extends StatelessWidget {
  const IntakeTimeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    TimeOfDay intakeTime = TimeOfDay.now();
    return Container(
      height: MediaQuery.of(context).size.height / 2.75,
      decoration: BoxDecoration(
        color: theme.primaryContrastingColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton(
                    child: Text(S.of(context).cancel),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CupertinoButton.filled(
                    child: Text(S.of(context).save),
                    onPressed: () {
                      Navigator.of(context).pop(intakeTime);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) =>
                  intakeTime = TimeOfDay.fromDateTime(value),
            ),
          ),
        ],
      ),
    );
  }
}
