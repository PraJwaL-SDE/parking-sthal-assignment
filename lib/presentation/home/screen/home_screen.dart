import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parking_sthal_assginment/presentation/create_todo/screen/add_todo_screen.dart';
import 'package:parking_sthal_assginment/presentation/home/widgets/todo_list_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todoTitles = []; // List to store the titles
  bool isLoading = true; // To handle loading state
  String errorMessage = ""; // To show error message

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  // Function to fetch todos from the API with error and timeout handling
  Future<void> fetchTodos() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'))
          .timeout(const Duration(seconds: 5)); // Timeout after 5 seconds

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          todoTitles = data.map((todo) => todo['title'] as String).toList();
          isLoading = false; // Data is loaded, stop the loading
        });
      } else {
        throw Exception('Failed to load todos'); // Throw error if status code is not 200
      }
    } on TimeoutException catch (_) {
      setState(() {
        isLoading = false; // Stop loading
        errorMessage = 'Network Error: Request Timeout'; // Show timeout error message
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading
        errorMessage = 'Error: ${e.toString()}'; // Show other errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Task Manager",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage)) // Show error message if any
              : ListView.builder(
                  itemCount: todoTitles.length,
                  itemBuilder: (context, index) {
                    return TodoListItem(title: todoTitles[index]);
                  },
                ),
      // FloatingActionButton to navigate to Add Todo screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddTodoScreen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
