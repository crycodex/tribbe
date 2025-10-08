import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tribbe/controllers/gender_controller.dart';

class GenderActionSheet extends StatelessWidget {
  const GenderActionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final genderController = Get.find<GenderController>();

      return CupertinoActionSheet(
        title: const Text('Seleccionar Género'),
        message: const Text('Elige tu género'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              genderController.setGender('Masculino');
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
                    fontWeight: genderController.isMale
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                if (genderController.isMale) ...[
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
              genderController.setGender('Femenino');
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
                    fontWeight: genderController.isFemale
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                if (genderController.isFemale) ...[
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
    });
  }
}
