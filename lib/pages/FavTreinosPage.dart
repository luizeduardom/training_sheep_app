import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';

class FavTreinosPage extends StatefulWidget {
  @override
  _FavTreinosPageState createState() => _FavTreinosPageState();
}

class _FavTreinosPageState extends State<FavTreinosPage> {
  final user = FirebaseAuth.instance.currentUser;
  PerfilRepository repository = PerfilRepository();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _auth.signOutUser(context);
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body(){

  }

}