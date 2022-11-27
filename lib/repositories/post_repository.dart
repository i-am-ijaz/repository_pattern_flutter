import 'package:exception_handling/models/post/post.dart';
import 'package:exception_handling/repositories/base_repository.dart';

class PostRepostiory extends BaseRepository<Post> {
  @override
  String get serviceURL => "/posts";
}
