import 'package:flutter/material.dart';

void mostrarDlgGenerica(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Training Sheet'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
        ],
      );
    },
  );
}




