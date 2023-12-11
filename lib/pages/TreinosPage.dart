import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final CollectionReference _usuarios = FirebaseFirestore.instance.collection('usuarios');


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _nameController.text = documentSnapshot['nome'];
      _emailController.text = documentSnapshot['email'];
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
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
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
                  final String email = _emailController.text;

                  await _usuarios
                      .doc(documentSnapshot!.id)
                      .update({"nome": nome, "email": email});
                  _nameController.text = "";
                  _emailController.text = "";
                }
            )
          ],
        ),
      );
    }
    );
  }

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _nameController.text = documentSnapshot['nome'];
      _emailController.text = documentSnapshot['email'];
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
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
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
                      final String email = _emailController.text;

                      await _usuarios.add({"nome": nome, "email": email});
                      _nameController.text = "";
                      _emailController.text = "";
                    }
                )
              ],
            ),
          );
        }
    );
  }

  Future<void> _delete(String userId) async {
    await _usuarios.doc(userId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário deletado com sucesso!")
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha de treino'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _auth.signOutUser(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      body: _body()
    );
  }


  _body(){
    return StreamBuilder(
        stream: _usuarios.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index){
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card (
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['nome']),
                    subtitle: Text(documentSnapshot['email']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(onPressed: () =>
                            _update(documentSnapshot),
                            icon: const Icon(Icons.edit)
                          ),
                          IconButton(onPressed: () =>
                            _delete(documentSnapshot.id),
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