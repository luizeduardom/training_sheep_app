import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_sheet_app/services/auth_service.dart';
import 'package:training_sheet_app/services/db_firestore.dart';
import '../model/treino.dart';


class PerfilRepository {
  Treino treino = Treino();
  late FirebaseFirestore db;
  late AuthService auth;


  PerfilRepository() {
    _startRepository();
  }


  _startRepository() async {
    await _startFirestore();
    await _readPerfil();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }
  
  _readPerfil() async {

  }

  saveAll(Treino treino, String uid_usuario) async {

  }

  saveUser({required String nome, required String email}) async {
    final docUser = FirebaseFirestore.instance.collection('usuarios').doc();
    final json = {
      'nome': nome,
      'email': email,
    };
    await docUser.set(json);
  }

}