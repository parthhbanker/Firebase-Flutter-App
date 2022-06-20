// ignore_for_file: use_build_context_synchronously

import 'package:basic/model/user_model.dart';
import 'package:basic/view/postView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    const PostView(),
    const Page2(),
    const Page3(),
    const Page4(),
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

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Page 2"),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Page 3"),
    );
  }
}

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
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
            margin: EdgeInsets.only(top: 10, bottom: 5),
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
            margin: EdgeInsets.only(top: 10, bottom: 5),
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
            margin: EdgeInsets.only(top: 10, bottom: 5),
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
            margin: EdgeInsets.only(top: 10, bottom: 5),
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
                  child: Text("Reset Password")),
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
