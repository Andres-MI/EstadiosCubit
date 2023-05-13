import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String contentText;

  const CustomDialog({super.key, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Aviso'),
      content: Text(contentText),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
