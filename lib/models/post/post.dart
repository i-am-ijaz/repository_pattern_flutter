import 'package:exception_handling/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Model {
  final int userId;
  final String title;
  final String body;

  Post(
    this.userId,
    this.title,
    this.body, {
    String? id,
  }) : super(id: id);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
