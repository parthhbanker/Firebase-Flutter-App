import 'dart:ui';

import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        right: false,
        left: false,
        child: Stack(
          children: [
            Positioned(
              bottom: -50,
              right: -50,
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
              top: 200,
              left: -100,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 25),
                        child: const Text(
                          "LOGO",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),*/
                      const SizedBox(
                        height: 30,
                      ),
                      const Image(
                        image: AssetImage("assets/3.png"),
                        alignment: Alignment.center,
                        height: 175,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: const Text(
                          "Hello!",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: const Text(
                          """Welcome to our application, best place
              to manage your schedule""",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 40,
                        margin: const EdgeInsets.all(30),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 27, 119, 194),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                      color: Color.fromARGB(255, 27, 119, 194),
                                      width: 2.0))),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        width: 200,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 27, 119, 194),
                                  width: 2.0,
                                  style: BorderStyle.solid)),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 27, 119, 194),
                                fontWeight: FontWeight.w800,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text("Or via social media")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Image(
                                      image: AssetImage("assets/google.png"))),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Image(
                                      image:
                                          AssetImage("assets/facebook.png"))),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Image(
                                      image: AssetImage("assets/twitter.png"))),
                            ],
                          )
                        ],
                      )
                    ],
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
