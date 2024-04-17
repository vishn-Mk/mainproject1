import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainproject1/services/api_end_points.dart';
import 'package:mainproject1/services/api_service.dart';
import 'package:mainproject1/services/db_service.dart';
import 'package:mainproject1/utils/constants.dart';

class PlayerTicketListScreen extends StatefulWidget {
  const PlayerTicketListScreen({Key? key}) : super(key: key);

  @override
  State<PlayerTicketListScreen> createState() => _PlayerTicketListScreenState();
}

class _PlayerTicketListScreenState extends State<PlayerTicketListScreen> {
  late Future<List<dynamic>> _futureTicketData;

  @override
  void initState() {
    super.initState();
    _futureTicketData = fetchTicketData();
  }

  Future<List<dynamic>> fetchTicketData() async {
    final response = await http.get(Uri.parse('${ApiEndoint.baseUrl}api/user/view-tournament-bookings/${DbService.getLoginId()}'));
    print(response.body);

    if (response.statusCode == 200) {

      // If the server returns a 200 OK response, parse the JSON
      return jsonDecode(response.body)['data'];
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load ticket data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 11, 9, 9)),
        title: const Text('Your Ticket'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureTicketData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final ticket = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      // Handle onTap
                    },
                    leading: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Image.network(
                        'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                      ),
                    ),
                    title: Text(
                      ticket['name'] ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(ticket['bookingTime'] ?? ''),
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
