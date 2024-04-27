import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/player/playercomplaint.dart';
import 'package:mainproject1/services/db_service.dart';
import 'package:mainproject1/utils/constants.dart';
import 'package:mainproject1/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class PlayerComplaintListScreen extends StatelessWidget {
  const PlayerComplaintListScreen({super.key});
  Future<List<dynamic>> _fetchComplaints() async {
    final response = await http.get(Uri.parse(
        '$baseUrl/api/user/view-complaints-player/${DbService.getLoginId()}'));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      print(data);
      return data;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _fetchComplaints(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Reply'),
                                content:  Text(snapshot.data![index]['reply']),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: Icon(Icons.message),
                        title: Text(snapshot.data![index]['title']),
                      );
                    },
                  );
                }
              },
            ),
          ),
          CustomButton(
            text: 'Add Complaint',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => playercomplaint(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
