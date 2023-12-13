import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../model/userLogged.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  String motivationalQuote = '...';
  PerfilRepository repository = PerfilRepository();
  AuthService _auth = AuthService();


  Future<void> fetchMotivationalQuote() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String quote = data['content'];
      setState(() {
        motivationalQuote = quote;
      });
    } else {
      setState(() {
        motivationalQuote = 'Erro ao obter frase. Erro: ${response.statusCode}';
      });
    }
  }


  @override
  void initState(){
    super.initState();
    fetchMotivationalQuote();
  }

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserLogged>(context).uid; //teste
    return Scaffold(
      body: _body()
    );
  }


  _body(){
    return SingleChildScrollView(
      child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 70),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text('Bem vindo, ${user!.displayName!}!', style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 120),
        Center(
          child: Icon(
            Icons.auto_awesome_outlined,
            size: 75,
            color: Colors.lightBlue.shade200,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            motivationalQuote,
            style: TextStyle(fontSize: 16,color: Colors.lightBlue.shade200),
            textAlign: TextAlign.center,
          ),
        ),
      ],

    ),
    )
    );
  }
}

/*

      SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/logo_training_sheet.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bem-vindo à Training Sheep',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(motivationalQuote),
            Text(user!.email!),
            Text(user!.displayName.toString()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
 */