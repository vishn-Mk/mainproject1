import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/admin/widgets/booking_details_widget.dart';


class ViewBookingList extends StatelessWidget {
  const ViewBookingList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Bookings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
    
    
    
      body: ListView.builder(
        itemCount: 5, // Example: 5 list items
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingDetailsPage(),
                  ),
                );
              },
              leading: const Icon(Icons.book),
              title: Text('Booking #$index'),
              subtitle: const Text('Date: 2022-02-16'),
              trailing: const Icon(Icons.keyboard_arrow_right,
                  color: Colors.grey), // Example date
            ),
          );
        },
      ),
    );
  }
}
