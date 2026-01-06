import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _todoList = [];
  final TextEditingController _controller = TextEditingController(); 

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todoList.add({
          "title": _controller.text,
          "isDone": false,
        });
        _controller.clear(); 
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _todoList[index]["isDone"] = !_todoList[index]["isDone"];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2), 
      appBar: AppBar(
        title: const Text("To-Do List", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 24, 88, 184),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Yeni bir görev ekle...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: _addTask,
                  backgroundColor: const Color.fromARGB(255, 24, 88, 184),
                  mini: true,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _todoList.isEmpty
                ? const Center(child: Text("Henüz bir görev eklemedin."))
                : ListView.builder(
                    itemCount: _todoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          leading: Checkbox(
                            value: _todoList[index]["isDone"],
                            onChanged: (value) => _toggleTask(index),
                            activeColor: Colors.green,
                          ),
                          title: Text(
                            _todoList[index]["title"],
                            style: TextStyle(
                              decoration: _todoList[index]["isDone"]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: _todoList[index]["isDone"] ? Colors.grey : Colors.black87,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () => _deleteTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}