// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      json['userId'] as int,
      json['title'] as String,
      json['body'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['userId'] = instance.userId;
  val['title'] = instance.title;
  val['body'] = instance.body;
  return val;
}
