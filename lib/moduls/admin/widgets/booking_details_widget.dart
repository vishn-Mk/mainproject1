import 'package:flutter/material.dart';

class BookingDetailsPage extends StatelessWidget {
  const BookingDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 15,);
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
      body:const Center(
        child:  Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RowText(
                  rightText: 'Name:',
                  leftText: 'abc',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                sizedBox,
      
                RowText(
                  rightText: 'Turfname',
                  leftText: 'abc turf',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                sizedBox,
                 RowText(
                  rightText: 'Category',
                  leftText: 'football',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                sizedBox,
                 RowText(
                  rightText: 'Time slot',
                  leftText: '10:00-12:00',
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                sizedBox,
                 RowText(
                  rightText: 'Total charge',
                  leftText: '100',
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowText extends StatelessWidget {
  const RowText({
    super.key,
    required this.rightText,
    required this.leftText,
  });

  final String rightText;
  final String leftText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rightText,
          style:const TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Spacer(),
        Text(
          leftText,
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
