import 'package:basic/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DecisionTree extends StatefulWidget {
  @override
  State<DecisionTree> createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {
  @override
  Widget build(BuildContext context) {
    return OnBoarding();
  }
}
