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
  final TextEditingController _seriesController = TextEditingController();
  final TextEditingController _repController = TextEditingController();
  late CollectionReference _treinos;
  late Stream<QuerySnapshot> _treinosQuery;


  Future<void> _update(String nome, String tipo, String series, String rep, String uid) async {
    if(uid != ""){
      _nameController.text = nome;
      _tipoController.text = tipo;
      _seriesController.text = series;
      _repController.text = rep;
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
            TextField(
              controller: _seriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Series'),
            ),
            TextField(
              controller: _repController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Repetições'),
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
                  final String series = _seriesController.text;
                  final String rep = _repController.text;

                  await _treinos
                      .doc(uid)
                      .update({"nome": nome, "tipo": tipo, "series": series, "rep": rep});
                  _nameController.text = "";
                  _tipoController.text = "";
                  _seriesController.text = '';
                  _repController.text = '';
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
      _seriesController.text = '';
      _repController.text = '';

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
                TextField(
                  controller: _seriesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Series'),
                ),
                TextField(
                  controller: _repController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Repetições'),
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
                      final String series = _seriesController.text;
                      final String rep = _repController.text;

                      await _treinos.add({"nome": nome, "tipo": tipo, "series": series, "rep": rep, "status": "ativo", "usuario": user!.uid});
                      _nameController.text = "";
                      _tipoController.text = "";
                      _seriesController.text = "";
                      _repController.text = "";
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
        content: Text("Treino excluído!", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        backgroundColor: Colors.redAccent,
    ));
  }
  Future<void> _concluido(String nome, String tipo, String series, String rep, String status, String uid) async {
    if(status == "ativo"){
      await _treinos
          .doc(uid)
          .update({"nome": nome, "tipo": tipo, "series": series, "rep": rep, "status": "concluido"});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Treino concluído!", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.lightGreen,
      ));
    }else{
      await _treinos
          .doc(uid)
          .update({"nome": nome, "tipo": tipo, "series": series, "rep": rep, "status": "ativo"});

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Treino ativo!", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color:
        Colors.white)),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black45,
      ));
    }
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
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 45.0),
        child: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade200,
        onPressed: () => _create(),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerFloat,
      body: Container(
        margin: EdgeInsets.only(left: 15, top: 40, right: 15, bottom: 180),
        child: _body()
        ),
      );
  }


  _body() {
    return StreamBuilder(
      stream: _treinosQuery,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> treinos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: treinos.length,
            itemBuilder: (context, index) {
              String idTreino = treinos[index].id;
              String nomeTreino = treinos[index]['nome'];
              String tipo = treinos[index]['tipo'];
              String series = treinos[index]['series'];
              String rep = treinos[index]['rep'];
              String status = treinos[index]['status'];
              Color cardColor = status == "concluido" ? Colors.lightGreen.shade900 : Colors.black38;
              return GestureDetector(
                onTap: () => _showDialog(context, nomeTreino, tipo, series, rep),
                child: Card(
                  color: cardColor,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('$nomeTreino', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('$tipo'),
                    trailing: SizedBox(
                      width: 144,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _update(nomeTreino, tipo, series, rep, idTreino),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _delete(idTreino),
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () => _concluido(nomeTreino, tipo, series, rep, status, idTreino),
                            icon: const Icon(Icons.check_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _showDialog(BuildContext context, String nomeTreino, String tipo, String series, String rep) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes do Treino'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nome do Treino: $nomeTreino'),
              Text('Tipo: $tipo'),
              Text('Séries: $series'),
              Text('Repetições: $rep'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

}