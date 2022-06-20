import 'package:basic/view/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/post.dart';
import '../sevice/getdata.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<Post>? posts;
  var isLoad = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isLoad,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 246, 237, 211),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                        offset: Offset(10, 10))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 5,
                      top: 10,
                    ),
                    child: Text(
                      posts![index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 0, 57, 104),
                    thickness: 1.0,
                    endIndent: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                    child: Text(
                      posts![index].body,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondPage(
                                      title: posts![index].title,
                                      body: posts![index].body,
                                    )));
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        side: const BorderSide(color: Colors.purple, width: 2),
                      ),
                      child: const Text(
                        "Read More",
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: posts?.length,
        ),
      ),
    );
  }

  getData() async {
    posts = await GetData().getPost();
    if (posts != null) {
      setState(() {
        isLoad = true;
      });
    }
  }
}
