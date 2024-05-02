import 'package:flutter/material.dart';

mostrarAlerta(BuildContext? context, String? titulo, String? subtitulo) {
  showAdaptiveDialog(
      context: context!,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(titulo!),
          content: Text(subtitulo!),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'))
          ],
        );
      });
}
