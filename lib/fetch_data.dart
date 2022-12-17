import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FetchData extends StatelessWidget {
  const FetchData({super.key});

  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<dynamic>> _fetchDataUsers() async {
    var result = await http.get(Uri.parse(apiUrl));
    print(jsonDecode(result.body));
    return jsonDecode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Fetch Data'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchDataUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(snapshot.data![index]['id'].toString()),
                    ),
                    title: Text(snapshot.data![index]['title']),
                    trailing: snapshot.data![index]['completed']
                        ? const Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        : const Icon(
                            Icons.remove_done,
                            color: Colors.red,
                          ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
