import 'package:parking_sthal_assginment/models/comment.dart';

class Todo {
  String id;
  String title;
  DateTime createdOn;
  Map<String, String> tags;
  List<Comment> comments;
  Map<String, bool> members; // Updated to Map<String, bool>
  String manager;

  // Constructor
  Todo({
    required this.id,
    required this.title,
    required this.createdOn,
    required this.tags,
    required this.comments,
    required this.members, // Updated to Map<String, bool>
    required this.manager,
  });

  // Factory method for creating a Todo instance from a JSON map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      tags: (json['tags'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key as String, value as String)),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((commentJson) => Comment.fromJson(commentJson))
              .toList() ??
          [],
      members: (json['members'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key as String, value as bool)),
      manager: json['manager'] as String,
    );
  }

  // Method for converting a Todo instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdOn': createdOn.toIso8601String(),
      'tags': tags,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'members': members, // Updated to Map<String, bool>
      'manager': manager,
    };
  }
}
