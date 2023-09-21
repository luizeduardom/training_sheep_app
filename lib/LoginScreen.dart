import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(50.0),
        color: Colors.blueGrey, // Fundo preto
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                height: 200.0,
                margin: const EdgeInsets.only(bottom: 50),
                child: Image.asset('assets/icon/login.png'),
              ),
              const CustomTextField(labelText: 'Usuário'),
              const SizedBox(height: 20.0),
              const CustomTextField(labelText: 'Senha', obscureText: true),
              const SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // lógica para a ação "Esqueci minha senha" aqui
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          'Esqueci minha senha',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 75.0),
              ElevatedButton(
                  onPressed: () {
                    // Implemente a lógica para o botão "Entrar" aqui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(150, 50),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 30.0),
              Container(
                margin: const EdgeInsetsDirectional.only(top: 30),
                child: const InkWell(
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  const CustomTextField(
      {super.key, required this.labelText, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
      ),
    );
  }
}