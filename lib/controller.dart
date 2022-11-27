import 'package:exception_handling/repositories/post_repository.dart';
import 'package:flutter/foundation.dart';

import 'models/post/post.dart';

class PostController {
  final _rep = PostRepostiory();
  List<Post> posts = [];

  Post post = Post(1, 'Title', 'Body', id: "1");

  Future<void> get() async {
    try {
      posts = await _rep.get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getById() async {
    try {
      post = await _rep.getById("1");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> create() async {
    try {
      post = (await _rep.create(post));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> update() async {
    try {
      post = (await _rep.update(post));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> delete() async {
    try {
      await _rep.delete(post);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
