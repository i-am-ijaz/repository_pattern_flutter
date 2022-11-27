import 'package:exception_handling/controller.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _cont = PostController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _cont.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          return ListView.builder(
            itemCount: _cont.posts.length,
            itemBuilder: (c, i) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_cont.posts[i].title),
                    Text(_cont.posts[i].body),
                  ],
                ),
              );
            },
          );

          // return const SizedBox();

          // return Card(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(_cont.post.title),
          //       Text(_cont.post.body),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
