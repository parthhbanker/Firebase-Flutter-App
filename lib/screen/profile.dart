import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    usernameController = TextEditingController(text: loggedInUser.username);
    emailController = TextEditingController(text: loggedInUser.email);
    phoneController = TextEditingController(text: loggedInUser.phone);
    addressController = TextEditingController(text: loggedInUser.address);
  }

  void getUserInfo() {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEditing = !isEditing;
          updateUserData();
          setState(() {});
        },
        child: isEditing ? const Icon(Icons.save) : const Icon(Icons.edit),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: IconButton(
                    icon: _image == null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(loggedInUser.dpURL.toString()),
                            radius: 200,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 200,
                          ),
                    iconSize: 120,
                    onPressed: !isEditing
                        ? null
                        : () {
                            pickImage();
                          }),
              ),
              const SizedBox(
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
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_rounded)),
                enabled: false,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.house_rounded)),
                enabled: isEditing,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_rounded)),
                enabled: isEditing,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPass() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: loggedInUser.email.toString());
  }

  void updateUserData() {
    if (!isEditing) {
      if (_image != null) {
        uploadImage();
      }

      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
            'username': usernameController.text,
            'email': emailController.text,
            'address': addressController.text,
            'phone': phoneController.text,
            'dpURL': downloadURL
          })
          .then((value) => getUserInfo())
          .then((value) => Fluttertoast.showToast(
                msg: "Information Upadted Successfully",
              ))
          .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
    }
  }

  Future pickImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showError("No image selected", const Duration(seconds: 2));
      }
    });
  }

  Future uploadImage() async {
    Reference ref =
        FirebaseStorage.instance.ref().child(loggedInUser.uid.toString());
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    print(downloadURL!);
    _image = null;
  }

  void showError(String text, Duration d) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
