import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainproject1/moduls/player/bookings/player_booking_details.dart';

import 'dart:convert';

import '../../../utils/constants.dart';



class PlayerBookingListScreen extends StatelessWidget {
  final String loginId;

  const PlayerBookingListScreen({Key? key, required this.loginId}) : super(key: key);

  Future<List<dynamic>> fetchBookings() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/player/view-all-bookings/$loginId'),
    );


    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Bookings'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> bookings = snapshot.data ?? [];
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    // Navigate to booking details screen
                    // You can pass booking details to the next screen if needed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerBookingsDetailsScreen(
                          details: bookings[index],
                          
                        ),
                      ),
                    );
                  },
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                    ),
                  ),
                  title: Text(
                    bookings[index]['hours'] ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(bookings[index]['date'] ?? ''),
                 
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
