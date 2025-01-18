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
  bool _allowComments = false;
  final List<String> _tags = [];
  final List<String> _members = ["Alice", "Bob", "Charlie"]; // Sample members
  final List<String> _selectedMembers = [];

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // If the form is valid, you can proceed with saving the todo data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todo Added: $_title')),
      );
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }

  // Function to add a new tag
  void _addTag(String tag) {
    if (tag.isNotEmpty) {
      setState(() {
        _tags.add(tag);
      });
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title Text Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
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
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  maxLines: 3,
                  onChanged: (value) => _description = value,
                ),
                const SizedBox(height: 16),

                // Add Tags Section
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Add Tag",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  onFieldSubmitted: _addTag,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: _tags
                      .map((tag) => Chip(
                            label: Text(tag),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                _tags.remove(tag);
                              });
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Allow Comments Checkbox
                CheckboxListTile(
                  value: _allowComments,
                  title: const Text("Allow Comments"),
                  onChanged: (value) {
                    setState(() {
                      _allowComments = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Select Members Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select Members",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                  ),
                  items: _members
                      .map((member) => DropdownMenuItem(
                            value: member,
                            child: Text(member),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null && !_selectedMembers.contains(value)) {
                      setState(() {
                        _selectedMembers.add(value);
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: _selectedMembers
                      .map((member) => Chip(
                            label: Text(member),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () {
                              setState(() {
                                _selectedMembers.remove(member);
                              });
                            },
                          ))
                      .toList(),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    "ADD TASK",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
