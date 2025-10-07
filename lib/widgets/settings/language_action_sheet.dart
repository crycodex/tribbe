import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tribbe/controllers/language_notifier.dart';

class LanguageActionSheet extends ConsumerWidget {
  const LanguageActionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoActionSheet(
      title: const Text('Seleccionar Idioma'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            ref
                .read(languageNotifierProvider.notifier)
                .setLocale(const Locale('es'));
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
