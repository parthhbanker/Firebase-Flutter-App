// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            createData(
                                nameController.text, emailController.text);
                          });
                        },
                        child: const Text('Submit')),
                    ElevatedButton(
                        onPressed: () {
                          editData(id);
                          setState(() {});
                        },
                        child: const Text('Update')),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: ListTile(
                            title: Text(data[index]['name']),
                            subtitle: Text(data[index]['email']),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          emailController.text =
                                              data[index]['email'];
                                          nameController.text =
                                              data[index]['name'];
                                          id = data[index]['id'].toString();
                                        });
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        deleteData(data[index]['id']);
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
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
      ),
    );
  }

  void fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);
    } else {
      throw Exception("Unable to load data");
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
}
