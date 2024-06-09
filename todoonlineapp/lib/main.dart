import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoonlineapp/Auth/auth_gate.dart';
import 'package:todoonlineapp/Pages/Home.dart';
import 'package:todoonlineapp/Pages/login.dart';
import 'package:todoonlineapp/Pages/register.dart';
import 'package:todoonlineapp/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:   AuthGate());
  }
}

