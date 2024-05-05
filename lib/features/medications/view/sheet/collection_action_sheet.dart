import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/features/settings/locale_cubit.dart';

class CollectionActionSheet extends StatelessWidget {
  final int currentIndex;
  final List<dynamic> enumCollection;
  const CollectionActionSheet(
      {super.key, required this.currentIndex, required this.enumCollection});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: List.generate(
        enumCollection.length,
        (index) => CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(index);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentIndex == index) const Icon(CupertinoIcons.check_mark),
              if (currentIndex == index) const SizedBox(width: 8),
              BlocBuilder<LocaleCubit, String>(
                builder: (context, state) {
                  return Text(state == 'ru'
                      ? enumCollection[index].titleRU
                      : enumCollection[index].titleEN);
                },
              ),
            ],
          ),
        ),
      ),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.of(context).pop(),
        isDefaultAction: true,
        child: const Text('Cancel'),
      ),
    );
  }
}
