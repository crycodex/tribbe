import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/controllers/gender_notifier.dart';

class GenderActionSheet extends ConsumerWidget {
  const GenderActionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genderState = ref.watch(genderNotifierProvider);

    return CupertinoActionSheet(
      title: const Text('Seleccionar Género'),
      message: const Text('Elige tu género'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(genderNotifierProvider.notifier).setGender('Masculino');
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('♂', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                'Masculino',
                style: TextStyle(
                  fontWeight: genderState.isMale
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (genderState.isMale) ...[
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.checkmark,
                  color: CupertinoColors.activeBlue,
                ),
              ],
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            ref.read(genderNotifierProvider.notifier).setGender('Femenino');
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('♀', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                'Femenino',
                style: TextStyle(
                  fontWeight: genderState.isFemale
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (genderState.isFemale) ...[
                const SizedBox(width: 8),
                const Icon(
                  CupertinoIcons.checkmark,
                  color: CupertinoColors.activeBlue,
                ),
              ],
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
    );
  }
}
