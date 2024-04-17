import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:mainproject1/moduls/public/public_ticket_booking.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../payment_screen.dart';

class PublicTournamentsDetailsScreen extends StatefulWidget {
  const PublicTournamentsDetailsScreen(
      {super.key, required this.tournamentDetails});

  final Map<String, dynamic> tournamentDetails;

  @override
  State<PublicTournamentsDetailsScreen> createState() =>
      _PublicTournamentsDetailsScreenState();
}

class _PublicTournamentsDetailsScreenState
    extends State<PublicTournamentsDetailsScreen> {
  final _controller = TextEditingController();
  final _noOfTicketController = TextEditingController();

  bool ispaid = false;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateFormat('MM/dd/yyyy').parse(widget.tournamentDetails['date']);
    final month = DateFormat('MMMM').format(dateTime);
    final day = DateFormat('dd').format(dateTime);
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            widget.tournamentDetails['tournament_name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.teal)),
                          child: Column(
                            children: [
                              Text(
                                month,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(day)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.tournamentDetails['description'],
                      maxLines: 15,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.emoji_events_outlined,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                Text(
                                  '₹${widget.tournamentDetails['win_price']}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.confirmation_num_outlined,
                                  color: Colors.teal,
                                  size: 30,
                                ),
                                Text(
                                  '₹${widget.tournamentDetails['ticket_price']}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                          text: ispaid ? 'book' : 'pay',
                          onPressed: () async {
                            if (ispaid) {
                              setState(() {});

                              addTicket(
                                context: context,
                                mobile: _controller.text,
                                noOfTickets:
                                    int.parse(_noOfTicketController.text),
                                date: widget.tournamentDetails['date'],
                                time: widget.tournamentDetails['time'],
                                tournamentId: widget.tournamentDetails['_id'],
                                tournamentName:
                                    widget.tournamentDetails['tournament_name'],
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Fill the field'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _controller,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            hintText: 'Phone Number',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          controller: _noOfTicketController,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            hintText: 'no of tickets',
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          final total =
                                              int.parse(_controller.text) *
                                                  int.parse(
                                                      widget.tournamentDetails[
                                                          'ticket_price']);
                                          ispaid = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentScreen(
                                                  totalAmount: total.toString(),
                                                ),
                                              ));

                                          Navigator.of(context).pop();

                                          setState(() {});
                                        },
                                        text: 'OK',
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addTicket(
      {required BuildContext context,
      required String mobile,
      required int noOfTickets,
      required String date,
      required String time,
      required String tournamentId,
      required String tournamentName}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16.0),
            Text("Booking..."),
          ],
        ),
      ),
    );

    try {
      var url = Uri.parse('$baseUrl/api/user/tournament-booking');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'mobile': mobile,
          'no_of_tickets': '$noOfTickets',
          'date': date,
          'time': time,
          'tournament_id': tournamentId,
        },
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('successfull!!!'),
            ),
          );

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PublicUserTicketBookingView(
                  name: widget.tournamentDetails['tournament_name'],
                  count: noOfTickets.toString(),
                  time: time,
                  date: date,
                ),
              ));
        }
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }
}
