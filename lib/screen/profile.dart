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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.account_circle),
                const SizedBox(
                  width: 30,
                ),
                Text(loggedInUser.username.toString()),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.email_rounded),
                const SizedBox(
                  width: 30,
                ),
                Text(loggedInUser.email.toString()),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.home_filled),
                const SizedBox(
                  width: 30,
                ),
                Text(loggedInUser.address.toString()),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.phone_android_outlined),
                const SizedBox(
                  width: 30,
                ),
                Text(loggedInUser.phone.toString()),
              ],
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.password_rounded),
              const SizedBox(
                width: 30,
              ),
              TextButton(
                  onPressed: () {
                    resetPass();
                  },
                  child: const Text("Reset Password")),
            ],
          ),
        ],
      ),
    );
  }

  void resetPass() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: loggedInUser.email.toString());
  }
}
