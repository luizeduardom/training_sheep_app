
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/LoginPage.dart';
import 'package:training_sheet_app/containers/dialogGen.dart';

class PaginaPrincipal extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout', textAlign: TextAlign.center),
            content: const Text('Você foi deslogado da sua conta.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo.
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              signOut(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo à página principal!'),
      ),
    );
  }
}