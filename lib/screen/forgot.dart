import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: -80,
              left: -120,
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(255, 14, 123, 213),
                          blurRadius: 15.0,
                          spreadRadius: 15.0,
                          blurStyle: BlurStyle.outer)
                    ]),
              ),
            ),
            Positioned(
              top: -20,
              right: -50,
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange,
                          blurRadius: 15.0,
                          spreadRadius: 15.0,
                          blurStyle: BlurStyle.outer)
                    ]),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Welcome Back Text
                        Container(
                          padding: const EdgeInsets.only(
                            top: 80,
                          ),
                          child: const Text(
                            "Welcome Back!",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Username Input
                        Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 25, right: 25),
                          child: TextFormField(
                            autofocus: true,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("* required");
                              }
                              // reg expression for email validation
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email!");
                              }

                              return null;
                            },
                            decoration:
                                const InputDecoration(label: Text("Email")),
                          ),
                        ),
                        // Forgot Password Button
                        Container(
                          width: 200,
                          height: 40,
                          margin: const EdgeInsets.only(top: 50),
                          child: OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                resetPass();
                                Navigator.pushReplacementNamed(
                                    context, '/onboarding');
                              }
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 27, 119, 194),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 27, 119, 194),
                                        width: 2.0))),
                            child: const Text(
                              "Send Link",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ),

                        // Login
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: const Text("Login!")),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetPass() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.toString());
  }
}
