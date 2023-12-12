import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_sheet_app/pages/FavTreinosPage.dart';
import 'package:training_sheet_app/pages/TreinosPage.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../model/userLogged.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  PerfilRepository repository = PerfilRepository();
  AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<UserLogged>(context).uid;
    return Scaffold(
      body: _body(uid)
    );
  }

  _body(String uid){
    return SingleChildScrollView(
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
            Text(uid),
            Text(user!.email!),
            Text(user!.displayName.toString()),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}