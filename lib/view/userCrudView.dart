// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class UserCrudView extends StatefulWidget {
  const UserCrudView({Key? key}) : super(key: key);

  @override
  State<UserCrudView> createState() => _UserCrudViewState();
}

class _UserCrudViewState extends State<UserCrudView> {
  List data = [];
  late String id;
  var emailController = TextEditingController();
  var nameController = TextEditingController();

  final Connectivity _connectivity = Connectivity();
  var isConnected = false, isError = false;
  var errorMessage = "";
  late StreamSubscription _subscription;

  var isAdd = false, isEdit = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    fetchData();
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isAdd = true;
          formDialog();
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: Visibility(
        visible: isConnected && data.isNotEmpty,
        replacement: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const CircularProgressIndicator.adaptive(),
              const SizedBox(height: 20),
              isConnected
                  ? const Text('Loading...')
                  : const Text('No Internet Connection'),
            ])),
        child: isError ? Center(child: Text(errorMessage)) : mainScreen(),
      ),
    );
  }

  SafeArea mainScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: data.isNotEmpty
                            ? Key(data[index]['id'].toString())
                            : const Key('0'),
                        confirmDismiss: (DismissDirection direction) async {
                          if (DismissDirection.endToStart == direction) {
                            return await deleteDialog(data[index]['id']);
                          } else if (DismissDirection.startToEnd == direction) {
                            setState(() {
                              isEdit = true;
                              formDialog();
                              emailController.text = data[index]['email'];
                              nameController.text = data[index]['name'];
                              id = data[index]['id'].toString();
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/200/300?blur?random=${data[index]['id']}"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.colorBurn),
                                filterQuality: FilterQuality.high),
                          ),
                          child: Container(
                            child: ListTile(
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.5),
                                radius: 30,
                                child: CircleAvatar(
                                  backgroundColor: Color(
                                          (math.Random().nextDouble() *
                                                  0x818FDE)
                                              .toInt())
                                      .withOpacity(1.0),
                                  radius: 25,
                                  child: Text(
                                    data[index]['name'][0],
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              title: Text(
                                data[index]['name'],
                                style: TextStyle(
                                    fontSize: Adaptive.sp(17),
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                data[index]['email'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future deleteDialog(id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Center(child: Text('Are you sure?')),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      deleteData(id);
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ));

  Future formDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: isAdd ? const Text('Add') : const Text('Edit'),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Visibility(
                      visible: isAdd || isEdit,
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                            ),
                          ),
                          TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: isAdd,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                createData(
                                    nameController.text, emailController.text);
                                Navigator.pop(context);
                                isAdd = false;
                              });
                            },
                            child: const Text('Submit')),
                      ),
                      Visibility(
                        visible: isEdit,
                        child: ElevatedButton(
                            onPressed: () {
                              editData(id);
                              Navigator.pop(context);
                              isEdit = false;
                              setState(() {});
                            },
                            child: const Text('Update')),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            isEdit = false;
                            isAdd = false;
                            setState(() {});
                          },
                          child: const Text('Close')),
                    ],
                  ),
                ],
              ),
            ),
          ));

  void fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
    } else if (response.statusCode == 404) {
      isError = true;
      errorMessage = "Page not found";
      setState(() {});
    } else {
      isError = true;
      errorMessage = "Unable to load data";
      setState(() {});
    }
  }

  void deleteData(id) async {
    print(id);
    final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
        headers: ({
          'Connection': 'keep-alive',
        }));

    if (response.statusCode == 200) {
      print("Deleted Successfully!");
    } else {
      throw Exception("Unable to delete data!");
    }
  }

  void editData(id) async {
    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
        body: jsonEncode(
            {'name': nameController.text, 'email': emailController.text}),
        headers: ({'content-type': 'application/json; charset=UTF-8'}));

    if (response.statusCode == 200) {
      print(response.body);
      print("Updated Successfully!");
      emailController.clear();
      nameController.clear();
    } else {
      throw Exception("Unable to update data!");
    }
  }

  void createData(name, email) async {
    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        body: jsonEncode({'name': name, 'email': email}),
        headers: ({'content-type': 'application/json; charset=UTF-8'}));

    if (response.statusCode == 201) {
      print("Added Successfully!");
      print(response.body);
      emailController.clear();
      nameController.clear();
    } else {
      throw Exception("Unable to add data!");
    }
  }

  void checkConnectivity() {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        setState(() {
          isConnected = true;
        });
      } else {
        setState(() {
          isConnected = false;
        });
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
