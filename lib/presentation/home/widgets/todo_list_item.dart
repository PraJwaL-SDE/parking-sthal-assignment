import 'package:flutter/material.dart';
import 'package:parking_sthal_assginment/presentation/details/screen/detail_screen.dart';

class TodoListItem extends StatefulWidget {
  final String title;
  final Map<String, String> pastelColoredTags;
  final int comments;
  final int attachments;
  final List<String> membersImg;

  const TodoListItem({
    Key? key,
    this.title = "Project Task Summary",
    this.pastelColoredTags = const {
      "Urgent": "#E74C3C",
      "In Progress": "#3498DB",
      "Completed": "#2ECC71",
      "Review": "#F1C40F",
      "High Priority": "#9B59B6",
    },
    this.comments = 3,
    this.attachments = 1,
    this.membersImg = const [
      "https://cdn-icons-png.flaticon.com/128/2202/2202112.png",
      "https://cdn-icons-png.flaticon.com/128/560/560277.png",
      "https://cdn-icons-png.flaticon.com/128/6997/6997662.png"
    ],
  }) : super(key: key);

  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late List<bool> _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = List.filled(widget.pastelColoredTags.length, false);
    _animateTags();
  }

  Future<void> _animateTags() async {
    for (int i = 0; i < _isVisible.length; i++) {
      await Future.delayed(
          const Duration(milliseconds: 200)); // Delay for each tag
      setState(() {
        _isVisible[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetailScreen()));
        },
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              children: widget.pastelColoredTags.entries.map((entry) {
                final index =
                    widget.pastelColoredTags.keys.toList().indexOf(entry.key);
                final color =
                    Color(int.parse(entry.value.replaceFirst('#', '0xff')));

                return AnimatedOpacity(
                  opacity: _isVisible[index] ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      border: Border.all(color: color, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      entry.key,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Image.asset(
                  "assets/icons/comment.png",
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4.0),
                Text("${widget.comments}"),
                const SizedBox(width: 16.0),
                Image.asset(
                  "assets/icons/attach_document.png",
                  height: 16,
                ),
                const SizedBox(width: 4.0),
                Text("${widget.attachments}"),
                const Spacer(),
                SizedBox(
                  height: 32.0,
                  width: (widget.membersImg.length * 24.0).toDouble(),
                  child: Stack(
                    children: List.generate(widget.membersImg.length, (index) {
                      return Positioned(
                        left: index * 20.0,
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundImage:
                              NetworkImage(widget.membersImg[index]),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
