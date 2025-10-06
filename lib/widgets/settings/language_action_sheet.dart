import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tribbe/controllers/system/language_controller.dart';

class LanguageActionSheet extends StatelessWidget {
  final LanguageController languageController;

  const LanguageActionSheet({super.key, required this.languageController});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Seleccionar Idioma'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            languageController.setLocale(const Locale('es', 'ES'));
            Navigator.pop(context);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🇪🇸', style: TextStyle(fontSize: 20)),
              SizedBox(width: 8),
              Text('Español'),
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
