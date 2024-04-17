import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';



class PlayerBookingsDetailsScreen
    extends StatelessWidget {


  final Map<String,dynamic> details;

  const PlayerBookingsDetailsScreen({super.key, required this.details});
   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: TicketWidget(
          width: 350,
          height: 400,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(
            details: details,
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
   required  this.details
  }) : super(key: key);

  final Map<String,dynamic> details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1.0, color: Colors.green),
              ),
              child:  Center(
                child: Text(
                  details['status'] == '0' ? 'pending' : 'completed',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Booked',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget('Name', 'football', 'Date', '${details['date']}'),
              const SizedBox(height: 10,),
              ticketDetailsWidget('Start', details['start_time'],'','' ),
              const SizedBox(height: 10,),
              ticketDetailsWidget('End',details['end_time'] ,  'Houres', details['hours'],),
            ],
          ),
        ),
        const Spacer(),
        const SizedBox(height: 30),
        const Text('         Developer: instagram.com/DholaSain')
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            firstTitle,
            style: const TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              firstDesc,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    ),
    const Spacer(),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          secondTitle,
          style: const TextStyle(color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            secondDesc,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ],
    ),
  ]);
}
