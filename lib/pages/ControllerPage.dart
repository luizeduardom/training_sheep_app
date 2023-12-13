import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:training_sheet_app/pages/FichaPage.dart';
import 'package:training_sheet_app/pages/Fichas/FichaIniciantePage.dart';
import 'package:training_sheet_app/pages/TreinosPage.dart';
import 'package:training_sheet_app/pages/HomePage.dart';
import 'package:training_sheet_app/repository/treino_repository.dart';

import '../services/auth_service.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  final user = FirebaseAuth.instance.currentUser;
  AuthService _auth = AuthService();

  int pageAtual = 0;
  late PageController _pageController;


  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: pageAtual);
  }


  setPaginaAtual(pagina){
    setState(() {
      pageAtual = pagina;
    });
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
        body: _body(),
        bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GNav(
          backgroundColor: Colors.transparent,
          activeColor: Colors.lightBlue.shade200,
          tabBackgroundColor: Colors.black26,
          tabBorderRadius: 50,
          gap: 8,
          tabs: const [
            GButton(icon: Icons.home, text: 'Home', padding: EdgeInsets.all(15)),
            GButton(icon: Icons.accessibility_new, text: 'Meus Treinos', padding: EdgeInsets.all(15)),
            GButton(icon: Icons.article, text: 'Ficha', padding: EdgeInsets.all(15)),
          ],
          onTabChange: (pagina){
            _pageController.animateToPage(pagina, duration: Duration(milliseconds: 400), curve: Curves.easeOutExpo);
        },
          ),
        )
        )
    );
  }

  _body(){
    return PageView(
      controller: _pageController,
      children: [
        HomePage(),
        TreinosPage(),
        FichaPage()
      ],
      onPageChanged: setPaginaAtual,
    );
  }

}