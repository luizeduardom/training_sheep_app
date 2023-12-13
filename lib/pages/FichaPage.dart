import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';
import 'fichas/FichaAvancadoPage.dart';
import 'fichas/FichaIniciantePage.dart';
import 'fichas/FichaIntermediarioPage.dart';

class FichaPage extends StatefulWidget {
  @override
  _FichaPageState createState() => _FichaPageState();
}

class _FichaPageState extends State<FichaPage> {
  final user = FirebaseAuth.instance.currentUser;
  PerfilRepository repository = PerfilRepository();
  AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Center(
            child: Icon(
              Icons.article,
              size: 75,
              color: Colors.lightBlue.shade200,
            ),
          ),
          const SizedBox(height: 30.0),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FichaIniciantePage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                    ),
                    child: Text('Nível Iniciante', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FichaIntermediarioPage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent)
                      ),
                      child: Text('Nível Intermediário', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FichaAvancadoPage(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                      ),
                      child: Text('Nível Avançado', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    )
    );
  }

}