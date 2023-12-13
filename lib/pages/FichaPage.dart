import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';

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
      body: Text('ficha')
    );
  }

}