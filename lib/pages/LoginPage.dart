
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_sheet_app/pages/RegisterPage.dart';

import 'PaginaPrincipal.dart';
import '../components/dialogGen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isEmailFieldValid = true;
  bool _isPasswordFieldValid = true;
  bool _passwordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateEmailTextField(String text) {
    if (text.isEmpty) {
      setState(() {
        _isEmailFieldValid = false; // O campo não é válido
      });
    } else {
      setState(() {
        _isEmailFieldValid = true; // O campo é válido
      });
    }
  }

  void _validatePasswordTextField(String text) {
    if (text.isEmpty) {
      setState(() {
        _isPasswordFieldValid = false; // O campo não é válido
      });
    } else {
      setState(() {
        _isPasswordFieldValid = true; // O campo é válido
      });
    }
  }

  void _login() {
    if (_isPasswordFieldValid && _isEmailFieldValid){
      _signIn();
    } else {
      mostrarDlgGenerica(context, "Preencha os campos necessários");
    }
  }


  void _register() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => RegisterPage(),
    ));
  }



  Future<void> _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
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





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Adicionado um SingleChildScrollView para retirar o overflow de pixel. Permite rolar a pagina pra baixo também.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/icon/logo_training_sheet.png',
                  height: 295),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    onChanged: _validateEmailTextField,
                    decoration: InputDecoration(labelText: 'Email',
                      errorText: _isEmailFieldValid ? null : 'Preencha o campo',),
                  ),
                  TextField(
                    controller: _passwordController,
                    onChanged: _validatePasswordTextField,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      errorText: _isPasswordFieldValid ? null : 'Preencha o campo',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText:
                        !_passwordVisible, // Alterna entre texto normal e texto oculto
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: const Text('Entrar', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 60.0),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    ),
                    child: const Text('Criar uma conta', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
