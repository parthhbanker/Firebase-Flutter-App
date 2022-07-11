// ignore_for_file: use_build_context_synchronously
import 'package:basic/model/user_model.dart';
import 'package:basic/screen/profile.dart';
import 'package:basic/view/userCrudView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    const UserCrudView(),
    const Profile(),
    const Profile(),
    const Profile(),
  ];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Project"),
      ),
      body: pages[pageIndex],
      drawer: drawer(context),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(loggedInUser.username.toString()),
            accountEmail: Text(loggedInUser.email.toString()),
            arrowColor: Colors.black,
            currentAccountPicture:
                const Image(image: AssetImage('assets/3.png')),
          ),
          ListTile(
            title: const Text("Phone Number"),
            subtitle: Text(loggedInUser.phone.toString()),
            leading: const Icon(Icons.phone),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Address"),
            subtitle: Text(loggedInUser.address.toString()),
            leading: const Icon(Icons.location_city),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Log Out"),
            leading: const Icon(Icons.logout),
            onTap: () {
              logout(context);
            },
          ),
        ],
      ),
    );
  }

  Container bottomNavBar() {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.newspaper,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.newspaper_rounded,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.shop,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.shop_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.pentagon,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.pentagon_outlined,
                    color: Colors.white,
                  ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }
}
