import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tribbe/controllers/system/theme_controller.dart';

class ThemeActionSheet extends StatelessWidget {
  final ThemeController themeController;

  const ThemeActionSheet({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Seleccionar Tema'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            themeController.setThemeMode(ThemeMode.light);
            Navigator.pop(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.sun_max_fill,
                color: CupertinoColors.activeBlue,
              ),
              SizedBox(width: 8),
              Text('Claro'),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            themeController.setThemeMode(ThemeMode.dark);
            Navigator.pop(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.moon_fill, color: CupertinoColors.activeBlue),
              SizedBox(width: 8),
              Text('Oscuro'),
            ],
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            themeController.setThemeMode(ThemeMode.system);
            Navigator.pop(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.settings, color: CupertinoColors.activeBlue),
              SizedBox(width: 8),
              Text('Sistema'),
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
