import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tribbe/controllers/system/gender_controller.dart';

class GenderActionSheet extends StatelessWidget {
  final GenderController genderController;

  const GenderActionSheet({super.key, required this.genderController});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Seleccionar Género'),
      message: const Text('Elige tu género'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            genderController.setGender(Gender.masculine);
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
                  fontWeight: genderController.gender == Gender.masculine
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (genderController.gender == Gender.masculine) ...[
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
            genderController.setGender(Gender.feminine);
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
                  fontWeight: genderController.gender == Gender.feminine
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              if (genderController.gender == Gender.feminine) ...[
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
