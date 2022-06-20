import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String title;
  final String body;
  const SecondPage({Key? key,required this.title, required  this.body}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black
                  ),
                ),
              ),

              const Divider(
                color: Colors.black,
                thickness: 2.0,
                indent: 15.0,
                endIndent: 15.0,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  widget.body,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}