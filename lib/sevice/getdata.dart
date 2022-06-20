import 'package:basic/model/post.dart';
import 'package:http/http.dart' as http;

class GetData {
  Future<List<Post>?> getPost() async{
    var data = http.Client();

    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var response = await data.get(url);

    if (response.statusCode == 200){
      var json = response.body;
      return postFromJson(json);
    }
    return null;
  }

  
}