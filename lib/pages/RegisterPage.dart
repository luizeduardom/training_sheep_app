import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:training_sheet_app/components/decorations/auth_input.dart';
import 'package:training_sheet_app/pages/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();


  void _backLogin(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: getAuthInputDecoration("E-mail"),
                    validator: (String? value){
                      if (!value!.contains("@")){
                        return "O e-mail não é válido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _senhaController,
                    decoration: getAuthInputDecoration("Senha")
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                      controller: _senhaController,
                      decoration: getAuthInputDecoration("Confirma a senha")
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: _backLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
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
            )
          ]
        )
    );
  }

}