import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../FichaPage.dart';

class FichaIniciantePage extends StatefulWidget {
  @override
  _FichaIniciantePageState createState() => _FichaIniciantePageState();
}

class _FichaIniciantePageState extends State<FichaIniciantePage> {
  final user = FirebaseAuth.instance.currentUser;
  AuthService _auth = AuthService();
  late CollectionReference _treinos;
  late Stream<QuerySnapshot> _treinosQuery;



  @override
  void initState(){
    super.initState();
    _treinos = FirebaseFirestore.instance.collection('ficha');
    _treinosQuery = FirebaseFirestore.instance
        .collection('ficha')
        .where('nivel', isEqualTo: "Iniciante")
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Container(
            margin: EdgeInsets.only(top: 25.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: Icon(Icons.fitness_center, size: 30),
              title: Text('Training Sheet',
                  style: TextStyle(fontSize: 17)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    _auth.signOutUser(context);
                  },
                ),
              ],
            ),
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_sharp, color: Colors.black87),
          backgroundColor: Colors.blueGrey,
        ),
      body: Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 110),
          child: _body()
      ),
    );
  }

  _body(){
    return StreamBuilder(
      stream: _treinosQuery,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> treinos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: treinos.length,
            itemBuilder: (context, index) {
              String nome = treinos[index]['nome'];
              String repeticoes = treinos[index]['repeticoes'];
              String series = treinos[index]['series'];
              String tipo = treinos[index]['tipo'];
              return GestureDetector(
                onTap: () => _showDialog(context, nome, tipo, series, repeticoes),
                child: Card(
                  color: Colors.black38,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('$nome', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('$tipo'),
                    trailing: SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _showDialog(context, nome, tipo, series, repeticoes),
                            icon: const Icon(Icons.star_border, color: Colors.lightGreen,),
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


  void _showDialog(BuildContext context, String nome, String tipo, String series, String repeticoes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalhes do Treino'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nome: $nome'),
              Text('Tipo: $tipo'),
              Text('Séries: $series'),
              Text('Repetições: $repeticoes'),
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