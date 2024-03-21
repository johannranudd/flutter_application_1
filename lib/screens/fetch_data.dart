import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For json decoding

class FetchData extends StatefulWidget {
  final Function(int) onNavigate;

  const FetchData({super.key, required this.onNavigate});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        print(users);
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception(
          'Failed to load users'); // Optionally, you can throw the error to handle it elsewhere
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              widget.onNavigate(2), // Navigate to 'About' page index
          child: const Text('Go to About'),
        ),
      ),
    );
  }
}
