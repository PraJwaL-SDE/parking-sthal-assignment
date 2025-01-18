import 'package:parking_sthal_assginment/models/todo.dart';


class User {
  String id;
  String name;
  String email;
  String role;

  // Constructor
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // Factory method for creating a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }

  // Method for converting a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}

class Manager extends User {
  List<Todo> assignedTodos;

  // Constructor
  Manager({
    required String id,
    required String name,
    required String email,
    required String role,
    this.assignedTodos = const [],
  }) : super(id: id, name: name, email: email, role: role);

  // Factory method for creating a Manager instance from a JSON map
  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      assignedTodos: (json['assignedTodos'] as List<dynamic>?)
              ?.map((todoJson) => Todo.fromJson(todoJson))
              .toList() ??
          [],
    );
  }

  // Method for converting a Manager instance to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'assignedTodos': assignedTodos.map((todo) => todo.toJson()).toList()});
  }
}

class Employee extends User {
  List<Todo> todos;

  // Constructor
  Employee({
    required String id,
    required String name,
    required String email,
    required String role,
    this.todos = const [],
  }) : super(id: id, name: name, email: email, role: role);

  // Factory method for creating an Employee instance from a JSON map
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      todos: (json['todos'] as List<dynamic>?)
              ?.map((todoJson) => Todo.fromJson(todoJson))
              .toList() ??
          [],
    );
  }

  // Method for converting an Employee instance to a JSON map
  @override
  Map<String, dynamic> toJson() {
    return super.toJson()..addAll({'todos': todos.map((todo) => todo.toJson()).toList()});
  }
}