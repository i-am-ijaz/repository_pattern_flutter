import 'package:flutter/foundation.dart' show mapEquals;

import 'package:json_annotation/json_annotation.dart';

import 'post/post.dart';

abstract class Model {
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;

  Model({this.id});

  Map<String, dynamic> toJson();

  Map<String, dynamic> explicitToJson() => toJson();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Model &&
          runtimeType == other.runtimeType &&
          other.id == id &&
          mapEquals(toJson(), other.toJson());

  @override
  int get hashCode => toJson().hashCode;
}

class ModelFactory {
  ModelFactory._();

  static Model getModel(Type type, Map<String, dynamic> json) {
    Model m;

    switch (type) {
      case Post:
        m = Post.fromJson(json);
        break;

      default:
        throw Exception(
          "Exception: No model found for type: ($type) found in factory",
        );
    }

    return m;
  }
}

String modelToId(Model? m) {
  return m!.id!;
}
