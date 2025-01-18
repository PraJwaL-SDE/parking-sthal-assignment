import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_sthal_assginment/core/firebase/routes.dart';
import 'package:parking_sthal_assginment/models/todo.dart';

class TodoFirebaseDatasource {
  FirebaseFirestore firestore;

  late CollectionReference todoCollection;

  TodoFirebaseDatasource({
    required this.firestore,
  }) {
    todoCollection = firestore.collection(FirebaseRoutes.TODO);
  }

  /// Fetch incomplete todos for a specific user
  Future<Stream<List<Todo>>> getIncompleteTodos(String userId) async {
    return todoCollection
        .where('members.$userId', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  /// Fetch complete todos for a specific user
  Future<Stream<List<Todo>>> getCompleteTodos(String userId) async {
    return todoCollection
        .where('members.$userId', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  /// Fetch all todos (both complete and incomplete)
  Future<Stream<Map<String, List<Todo>>>> getAllTodos(String userId) async {
    final incompleteStream = await getIncompleteTodos(userId);
    final completeStream = await getCompleteTodos(userId);

    return incompleteStream.asyncMap((incompleteTodos) async {
      final completeTodos = await completeStream.first;
      return {
        'incomplete': incompleteTodos,
        'complete': completeTodos,
      };
    });
  }

  /// Add a todo to the collection
  Future<void> addTodo(Todo todo) async {
    final docRef = todoCollection.doc(todo.id);
    await docRef.set(todo.toJson());
  }

  /// Mark a task as done for a specific user
  Future<void> markTaskAsDone(String todoId, String userId) async {
    final docRef = todoCollection.doc(todoId);
    await docRef.update({
      'members.$userId': true,
    });
  }

  /// Delete a todo by ID
  Future<void> deleteTodo(String todoId) async {
    final docRef = todoCollection.doc(todoId);
    await docRef.delete();
  }
}
