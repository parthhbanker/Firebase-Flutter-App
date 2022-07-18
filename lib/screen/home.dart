// ignore_for_file: use_build_context_synchronously
import 'package:basic/model/user_model.dart';
import 'package:basic/screen/profile.dart';
import 'package:basic/screen/sc2.dart';
import 'package:basic/screen/web.dart';
import 'package:basic/view/userCrudView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    const UserCrudView(),
    const Screen2(),
    const MainWebView(),
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

  String title = "Flutter Basic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
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
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
                title = "Home";
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
                title = "Upload Image";
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
                title = "Web View";
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
                title = "Profile";
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
