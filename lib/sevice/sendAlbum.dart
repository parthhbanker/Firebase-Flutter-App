import 'dart:convert';
import 'dart:async';
import 'package:basic/model/album.dart';
import 'package:http/http.dart' as http;

class SendAlbum {
  Future<Album> createAlbum(String title) async {
    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/albums'),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'title': title}));

    if (response.statusCode == 201) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create album");
    }
  }

  Future<Album> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    );

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> updateAlbum(String title) async {
    final response =
        await http.put(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
            headers: <String, String>{
              'Content-type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'title': title}));

    if (response.statusCode == 204 || response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
