import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_sheet_app/components/decorations/auth_input.dart';
import 'package:training_sheet_app/pages/LoginPage.dart';
import 'package:training_sheet_app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmSenhaController = TextEditingController();



  void _backLogin(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }

  void handleButtonRegister(){
    if(_formKey.currentState!.validate()){
      String nome = _nomeController.text;
      String email = _emailController.text;
      String senha = _senhaController.text;
      _auth.register(nome: nome, email: email, senha: senha, context: context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        centerTitle: true,
      ),
      body: _body()
    );
  }

  _body(){
    return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _nomeController,
                      decoration: getAuthInputDecoration("Nome"),
                      validator: (String? value){
                        if (value == null || value == ""){
                          return "Informe um nome válido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: getAuthInputDecoration("E-mail"),
                      validator: (String? value){
                        if (value == null){
                          return "O e-mail não pode ser vazio";
                        }
                        if (!value.contains("@")){
                          return "O e-mail não é válido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _senhaController,
                      decoration: getAuthInputDecoration("Senha"),
                      validator: (String? value){
                        if (value == null || value == ''){
                          return "Informe uma senha";
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                        controller: _confirmSenhaController,
                        decoration: getAuthInputDecoration("Confirma a senha"),
                        validator: (String? value){
                          if (value == null || value == ''){
                            return "Confirme a senha";
                          }
                          if(value != _senhaController.text){
                            return "As senhas não são iguais";
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: handleButtonRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade200,
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
                      ),
                      child: const Text('Criar conta',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                          )
                      ),
                    ),
                    const SizedBox(height: 70),
                    ElevatedButton(
                      onPressed: _backLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white24,
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: const Text('Fazer login',
                          style: TextStyle(fontSize: 16, color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            )
          ]
        )
    );
  }

}