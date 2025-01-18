class Comment {
  String id;
  String commentor;
  String comment;
  DateTime createdOn;

  // Constructor
  Comment({
    required this.id,
    required this.commentor,
    required this.comment,
    required this.createdOn,
  });

  // Factory method for creating a Comment instance from a JSON map
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      commentor: json['commentor'] as String,
      comment: json['comment'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
    );
  }

  // Method for converting a Comment instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commentor': commentor,
      'comment': comment,
      'createdOn': createdOn.toIso8601String(),
    };
  }
}
