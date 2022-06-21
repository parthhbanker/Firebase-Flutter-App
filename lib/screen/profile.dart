import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Page4State();
}

class _Page4State extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  final _formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var isEditing = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    print(loggedInUser.username.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () {
            isEditing = !isEditing;
            setState(() {});
          },
          icon: const Icon(Icons.edit)),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Image(
                image: AssetImage('assets/3.png'),
                height: 100,
                alignment: Alignment.center,
                isAntiAlias: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_rounded)),
              enabled: isEditing,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              decoration:
                  const InputDecoration(prefixIcon: Icon(Icons.email_rounded)),
              enabled: false,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: addressController,
              decoration:
                  const InputDecoration(prefixIcon: Icon(Icons.house_rounded)),
              enabled: isEditing,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: phoneController,
              decoration:
                  const InputDecoration(prefixIcon: Icon(Icons.phone_rounded)),
              enabled: isEditing,
            ),
          ],
        ),
      ),
    );
  }

  void resetPass() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: loggedInUser.email.toString());
  }
}
