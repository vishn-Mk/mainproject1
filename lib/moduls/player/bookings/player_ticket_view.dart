import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:screenshot/screenshot.dart';
import 'package:ticket_widget/ticket_widget.dart';

class PlayerTicketBookingView extends StatefulWidget {
  const PlayerTicketBookingView(
      {super.key,
      required this.name,
      required this.count,
      required this.date,
      required this.time});

  final String name;
  final String count;
  final String date;
  final String time;

  @override
  State<PlayerTicketBookingView> createState() =>
      _PlayerTicketBookingViewState();
}

class _PlayerTicketBookingViewState
    extends State<PlayerTicketBookingView> {
  final screenShotController = ScreenshotController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            const Spacer(),
            Screenshot(
              controller: screenShotController,
              child: TicketWidget(
                width: 350,
                height: 400,
                isCornerRounded: true,
                padding: const EdgeInsets.all(20),
                child: TicketData(
                  name: widget.name,
                  date: widget.date,
                  count: widget.count,
                ),
              ),
            ),
            const Spacer(),
           
          
          ],
        ));
  }

 
}

class TicketData extends StatelessWidget {
  const TicketData(
      {Key? key, required this.name, required this.date, required this.count})
      : super(key: key);

  final String name;
  final String date;
  final String count;

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
              child: Center(
                child: Text(
                  '$name',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Ticket',
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
              ticketDetailsWidget('Name', name, 'Date', date),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 53.0),
                child: ticketDetailsWidget('Tickets', count, '', ''),
              ),
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

  //ticket booking
}
