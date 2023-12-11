import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_sheet_app/components/dialogGen.dart';
import 'package:training_sheet_app/pages/LoginPage.dart';

import '../pages/HomePage.dart';

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> register({
    required String nome,
    required String email,
    required String senha,
    required BuildContext context
  }) async {
    try {
      UserCredential userC = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: senha);

      await userC.user!.updateDisplayName(nome);

      if (userC.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PaginaPrincipal(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == "email-already-in-use"){
        mostrarDlgGenerica(context, "E-mail já existe.");
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        mostrarDlgGenerica(context, "Senha ou usuário inválido.");
      } else if (e.code == 'channel-error') {
        mostrarDlgGenerica(context, "Erro de conexão com o canal");
      } else {
        mostrarDlgGenerica(context, "Autenticação Falhou");
        print(e);
      }
    }
  }


  Future<void> login({
    required String email,
    required String senha,
    required BuildContext context
    }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if (userCredential.user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PaginaPrincipal(),
        ));
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        mostrarDlgGenerica(context, "Senha ou usuário inválido.");
      } else if (e.code == 'channel-error') {
        mostrarDlgGenerica(context, "Erro de conexão com o canal");
      } else {
        mostrarDlgGenerica(context, "Autenticação Falhou");
        print(e);
      }
    }
  }


  void signOutUser(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
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

}