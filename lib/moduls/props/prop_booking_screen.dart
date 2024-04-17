import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';



class PropBookingListScreen extends StatefulWidget {
  const PropBookingListScreen({Key? key}) : super(key: key);

  @override
  State<PropBookingListScreen> createState() => _PropBookingListScreenState();
}

class _PropBookingListScreenState extends State<PropBookingListScreen> {
  Future<List<dynamic>> fetchBookings(String status) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/proprietor/view-all-$status-turf-bookings'),
    );

    print(
      Uri.parse(
          'https://vadakara-mca-turf-backend.onrender.com/api/proprietor/view-all-$status-turf-bookings'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Bookings'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(
                text: 'Confirmed',
              ),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent('pending'),
            _buildTabContent('confirmed'),
            _buildTabContent('completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String status) {
    return FutureBuilder<List<dynamic>>(
      future: fetchBookings(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('No data'));
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
                    // Handle the booking details
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Booking Details'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Service: ${bookings[index]['service']}'),
                            Text('Hour: ${bookings[index]['hour']}'),
                            Text('Date: ${bookings[index]['date']}'),
                            Text('Total: ${bookings[index]['total']}'),
                          ],
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
                    bookings[index]['date'] ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                      'Booking Time: ${bookings[index]['bookingTime'] ?? ''}'),
                  trailing: status == 'completed'
                      ? null
                      : CustomButton(
                          text: status,
                          onPressed: () {
                            if (status == 'pending') {
                              acceptBooking(bookings[index]['_id'], context);
                            }
                            if (status == 'confirmed') {

                              completeBooking(bookings[index]['_id']);
                            }
                          },
                        )),
            ),
          );
        
        
        
        }
      },
    );
  }

  Future<void> acceptBooking(String bookingId, BuildContext context) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(),
              Text("Accepting booking..."),
            ],
          ),
        ),
      );

      // Send request to accept booking
      final response = await http.get(
        Uri.parse('$baseUrl/api/proprietor/accept-turf-booking/$bookingId'),
      );

      if (response.statusCode == 200) {
        setState(() {});
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking accepted'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to accept booking');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to accept booking'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  Future<void> completeBooking(String bookingId) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircularProgressIndicator(),
              const Text("Completing booking..."),
            ],
          ),
        ),
      );

      // Send request to complete booking
      final response = await http.get(
        Uri.parse('https://vadakara-mca-turf-backend.onrender.com/api/proprietor/complete-turf-booking/$bookingId'),
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Booking completed'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to complete booking');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to complete booking'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
