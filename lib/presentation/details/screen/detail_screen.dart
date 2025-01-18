import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Demo data for task details
  String taskTitle = 'Review Project';
  String taskDescription = 'This is a detailed description of the task. Review the project and ensure that all features are implemented correctly.';
  
  // Demo Comments Data
  List<Map<String, dynamic>> comments = [
    {
      'userName': 'John Doe',
      'avatar': 'https://cdn-icons-png.flaticon.com/128/2202/2202112.png',
      'comment': 'Looking great so far!',
    },
    {
      'userName': 'Jane Smith',
      'avatar': 'https://cdn-icons-png.flaticon.com/128/560/560277.png',
      'comment': 'Need to improve the UI design.',
    },
  ];

  // Demo Attachments Data (Todo's Attachments)
  List<String> attachments = [
    'https://www.example.com/attachment1',
    'https://www.example.com/attachment2',
  ];

  bool isTaskComplete = false;

  late List<bool> _isTagVisible;
  Map<String, String> tags = {
    "Urgent": "#E74C3C",
    "In Progress": "#3498DB",
    "Completed": "#2ECC71",
    "Review": "#F1C40F",
    "High Priority": "#9B59B6",
  };

  @override
  void initState() {
    super.initState();
    _isTagVisible = List.filled(tags.length, false);
    _animateTags();
  }

  Future<void> _animateTags() async {
    for (int i = 0; i < _isTagVisible.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200)); // Delay for each tag
      setState(() {
        _isTagVisible[i] = true;
      });
    }
  }

  // Open URL in the browser
  Future<void> _openAttachment(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Title
            Text(
              taskTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 12),

            // Task Description
            Text(
              taskDescription,
              style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 99, 99, 99)),
            ),
            const SizedBox(height: 20),

            // Tags Section
            const Text(
              'Tags',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: tags.entries.map((entry) {
                final index = tags.keys.toList().indexOf(entry.key);
                final color = Color(int.parse(entry.value.replaceFirst('#', '0xff')));

                return AnimatedOpacity(
                  opacity: _isTagVisible[index] ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      border: Border.all(color: color, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      entry.key,
                      style: TextStyle(color: color, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Attachments Section
            const Text(
              'Attachments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: attachments.map((url) {
                return GestureDetector(
                  onTap: () => _openAttachment(url),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Attachment',
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Comments Section
            const Text(
              'Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // User Avatar
                            CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(comment['avatar']),
                            ),
                            const SizedBox(width: 12.0),

                            // Comment and Attachments
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // User Name
                                  Text(
                                    comment['userName'],
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4.0),

                                  // Comment Text
                                  Text(
                                    comment['comment'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Mark Task as Completed Button
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTaskComplete = !isTaskComplete;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      isTaskComplete ? Colors.green : Colors.blue),
                ),
                child: Text(isTaskComplete ? 'Task Completed' : 'Mark as Completed'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
