import 'dart:ui';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  var isPasswordHidden = false;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();
  final emailController = TextEditingController();

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
                            "Create an Account",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Username Input
                        Container(
                          margin: const EdgeInsets.only(
                              top: 50, left: 25, right: 25),
                          child: TextFormField(
                            controller: usernameController,
                            autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration:
                                const InputDecoration(label: Text("Username")),
                          ),
                        ),

                        // Email Input
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 25, right: 25),
                          child: TextFormField(
                            autofocus: true,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                const InputDecoration(label: Text("Email")),
                          ),
                        ),

                        // Password Input
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 25, right: 25),
                          child: TextFormField(
                            obscureText: isPasswordHidden,
                            autofocus: true,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration:
                                const InputDecoration(label: Text("Password")),
                          ),
                        ),

                        // Confirm Password Input
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 25, right: 25),
                          child: TextFormField(
                            obscureText: isPasswordHidden,
                            autofocus: true,
                            controller: conPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                                label: Text("Confirm Password")),
                          ),
                        ),

                        // Sign up Button
                        Container(
                          width: 200,
                          height: 40,
                          margin: const EdgeInsets.only(top: 50),
                          child: OutlinedButton(
                            onPressed: () {},
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
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(top: 160),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  },
                                  child: const Text("Login"))
                            ],
                          ),
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
}
