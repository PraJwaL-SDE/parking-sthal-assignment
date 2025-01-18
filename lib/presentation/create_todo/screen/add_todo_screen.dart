import 'package:flutter/material.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _isImportant = false;

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, you can proceed with saving the todo data
      // For example, sending the data to an API or local storage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todo Added: $_title')),
      );
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Text Field
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 16),

              // Description Text Field
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 16),

              // Importance Checkbox
              CheckboxListTile(
                value: _isImportant,
                title: const Text("Mark as Important"),
                onChanged: (value) {
                  setState(() {
                    _isImportant = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Add Todo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
