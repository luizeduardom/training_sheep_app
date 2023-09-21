import 'package:flutter/material.dart';

import 'SplashScreen.dart';

void main() {
  runApp(const TrainingSheep());
}

class TrainingSheep extends StatelessWidget {
  const TrainingSheep({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
