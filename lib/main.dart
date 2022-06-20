import 'package:basic/decisiion_tree.dart';
import 'package:basic/screen/forgot.dart';
import 'package:basic/screen/home.dart';
import 'package:basic/screen/login.dart';
import 'package:basic/screen/onboarding.dart';
import 'package:basic/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const DecisionTree(),
        '/onboarding': (context) => const OnBoarding(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/forgot': ((context) => const ForgotPassword())
      },
    );
  }
}
