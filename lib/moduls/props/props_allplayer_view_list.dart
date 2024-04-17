import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';


class PropsAllPlayersList extends StatelessWidget {
  const PropsAllPlayersList({Key? key}) : super(key: key);

  Future<List<dynamic>> _fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/api/proprietor/view-all-players'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final playersData = jsonData['data'] as List<dynamic>;
      return playersData;
    } else {
      throw Exception('Failed to load players');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All players'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchPlayers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final players = snapshot.data!;
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Handle the booking details
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      player['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Mobile: ${player['mobile']}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
