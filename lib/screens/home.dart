import 'package:flutter/material.dart';
import "package:flutter_application_1/models/todo.dart";
import 'package:flutter_application_1/services/todo_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;
  List<Todo> _todos = [];

  void getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _todos = await TodoService.fetchTodos();
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load todos: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _todos.isEmpty
              ? Center(
                  child: ElevatedButton(
                    onPressed: getData,
                    child: const Text('Get data'),
                  ),
                )
              : ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    final todo = _todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      trailing:
                          Icon(todo.completed ? Icons.check : Icons.close),
                    );
                  },
                ),
    );
  }
}
