import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:training_sheet_app/model/userLogged.dart';
import 'components/SplashScreen.dart';
import 'services/firebase_options.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TrainingSheep());
}

class TrainingSheep extends StatelessWidget {
  const TrainingSheep({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.lightBlue
    );

    return ChangeNotifierProvider(
        create: (context) => UserLogged(),
      child: MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}
