import 'package:basic/decisiion_tree.dart';
import 'package:basic/screen/forgot.dart';
import 'package:basic/screen/home.dart';
import 'package:basic/screen/login.dart';
import 'package:basic/screen/onboarding.dart';
import 'package:basic/screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: ((context, orientation, screenType) {
        return MaterialApp(
          title: 'Flutter Practice',
          theme: ThemeData(
            primaryColor: Colors.black,
            bottomAppBarColor: Colors.black,
            // make primary swatch black using material color
            primarySwatch: const MaterialColor(
              0xFF000000,
              <int, Color>{
                50: Color(0xFF000000),
                100: Color(0xFF000000),
                200: Color(0xFF000000),
                300: Color(0xFF000000),
                400: Color(0xFF000000),
                500: Color(0xFF000000),
                600: Color(0xFF000000),
                700: Color(0xFF000000),
                800: Color(0xFF000000),
                900: Color(0xFF000000),
              },
            ),
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
      }),
    );
  }
}
