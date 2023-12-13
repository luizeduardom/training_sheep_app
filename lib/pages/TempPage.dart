import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';

class TempPage extends StatefulWidget {
  @override
  _TempPageState createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  final user = FirebaseAuth.instance.currentUser;
  PerfilRepository repository = PerfilRepository();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('temp')
    );
  }


}