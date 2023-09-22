import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text(
                'Logado.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Feche o diálogo
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

    } catch (e) {
      // Tratar erros de autenticação, como usuário ou senha inválidos, exibindo um diálogo de erro.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro de autenticação'),
            content: const Text(
                'Usuário ou senha inválidos. Verifique suas credenciais e tente novamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Feche o diálogo
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      print('Erro de autenticação: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child:
              Image.asset('assets/icon/logo_training_sheet.png', height: 295),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Ajuste o valor vertical conforme necessário
                  ),
                  child: Text('Entrar', style: TextStyle(fontSize: 16),),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Funcao de registrar
                  },
                  child: Text('Registrar', style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}