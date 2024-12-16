import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectadopet/screens/LoginScreen.dart';
import 'package:projectadopet/screens/PetListScreen.dart';
import 'package:projectadopet/screens/RegisterScreen.dart';
import 'package:projectadopet/screens/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProjectAdopetApp());
}

class ProjectAdopetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Adopet',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => PetListScreen(),
      },
    );
  }
}

