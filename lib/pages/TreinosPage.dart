import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_sheet_app/components/dialogGen.dart';
import 'package:training_sheet_app/pages/LoginPage.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';

class TreinosPage extends StatefulWidget {
  @override
  _TreinosPageState createState() => _TreinosPageState();
}

class _TreinosPageState extends State<TreinosPage> {
  AuthService _auth = AuthService();
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  late CollectionReference _treinos;
  late Stream<QuerySnapshot> _treinosQuery;


  Future<void> _update(String nome, String tipo, String uid) async {
    if(uid != ""){
      _nameController.text = nome;
      _tipoController.text = tipo;
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx){
      return Padding(
        padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery
                .of(ctx)
                .viewInsets
                .bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _tipoController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                child: const Text('Update'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).indicatorColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () async {
                  final String nome = _nameController.text;
                  final String tipo = _tipoController.text;

                  await _treinos
                      .doc(uid)
                      .update({"nome": nome, "tipo": tipo});
                  _nameController.text = "";
                  _tipoController.text = "";
                }
            )
          ],
        ),
      );
    }
    );
  }
  Future<void> _create() async {
      _nameController.text = '';
      _tipoController.text = '';

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    child: const Text('Salvar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).indicatorColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () async {
                      final String nome = _nameController.text;
                      final String tipo = _tipoController.text;

                      await _treinos.add({"nome": nome, "tipo": tipo, "usuario": user!.uid});
                      _nameController.text = "";
                      _tipoController.text = "";
                    }
                )
              ],
            ),
          );
        }
    );
  }
  Future<void> _delete(String userId) async {
    await _treinos.doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário deletado com sucesso!")
    ));
  }


  @override
  void initState(){
    super.initState();
    _treinos = FirebaseFirestore.instance.collection('treinos');
    _treinosQuery = FirebaseFirestore.instance
        .collection('treinos')
        .where('usuario', isEqualTo: user!.uid)
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () => _create(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      body: _body()
    );
  }


  _body(){
    return StreamBuilder(
        stream: _treinosQuery,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            List<QueryDocumentSnapshot> treinos = snapshot.data!.docs;
            return ListView.builder(
              itemCount: treinos.length,
              itemBuilder: (context, index){
                String idTreino = treinos[index].id;
                String nomeTreino = treinos[index]['nome'];
                String tipo = treinos[index]['tipo'];
                return Card (
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('$nomeTreino'),
                    subtitle: Text('$tipo'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () =>
                            _update(
                              nomeTreino, tipo, idTreino),
                            icon: const Icon(Icons.edit)
                          ),
                          IconButton(onPressed: () =>
                            _delete(idTreino),
                            icon: const Icon(Icons.delete)
                          )
                        ],
                      )
                    ),
                  ),
                );
              }
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );
  }

}