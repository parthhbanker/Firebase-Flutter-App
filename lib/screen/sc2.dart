// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadURL;

  Future pickImage() async {
    final pick = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        showError("No image selected", const Duration(seconds: 2));
      }
    });
  }

  Future uploadImage() async {
    Reference ref = FirebaseStorage.instance.ref().child('images');
    await ref.putFile(_image!);
    downloadURL = await ref.getDownloadURL();
    print(downloadURL!);
  }

  void showError(String text, Duration d) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: SizedBox(
            height: 500,
            width: double.infinity,
            child: Column(children: [
              const Text("Upload Image"),
              const SizedBox(height: 10),
              Expanded(
                flex: 4,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: _image == null
                      ? const Center(
                          child: Text("No Image Selected"),
                        )
                      : Image.file(_image!),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text("Select Image")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    uploadImage();
                  },
                  child: Text("Upload")),
            ]),
          ),
        ),
      )),
    );
  }
}
