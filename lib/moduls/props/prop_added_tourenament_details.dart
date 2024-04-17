import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';

class PropTournamentsDetailsScreen extends StatefulWidget {
  const PropTournamentsDetailsScreen({super.key, required this.tournamentDetails});

 final Map<String,dynamic> tournamentDetails;

  @override
  State<PropTournamentsDetailsScreen> createState() =>
      _PropTournamentsDetailsScreenState();
}

class _PropTournamentsDetailsScreenState
    extends State<PropTournamentsDetailsScreen> {



  
  @override
  Widget build(BuildContext context) {
    print(widget.tournamentDetails['status']);

    
    DateTime dateTime = DateFormat('MM/dd/yyyy').parse(widget.tournamentDetails['date']);
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
                          child:  Text(
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
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child:  Column(
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
                            child:  Column(
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
                    if(widget.tournamentDetails['status'] != '1')
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'Delete',
                              color: Colors.red,
                              onPressed: () async{

                                await deleteTournament(widget.tournamentDetails['_id']);
                                Navigator.pop(context,true);
                                
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'Complete',
                              onPressed: () async {

                                await updateTournament(widget.tournamentDetails['_id']);
                                Navigator.pop(context,true);
                                
                              },
                            ),
                          ),)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> deleteTournament(String tournamentId) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularProgressIndicator(),
              Text("Deleting tournament..."),
            ],
          ),
        ),
      );

      // Send request to delete tournament
      final response = await http.get(
        Uri.parse('$baseUrl/api/proprietor/delete-tournament/$tournamentId'),
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament deleted'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to delete tournament');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete tournament'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



   Future<void> updateTournament(String tournamentId) async {
    try {
      // Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircularProgressIndicator(),
              const Text("Updating tournament..."),
            ],
          ),
        ),
      );

      // Send request to update tournament
      final response = await http.get(
        Uri.parse('$baseUrl/api/proprietor/update-tournament/$tournamentId'),
      );

      if (response.statusCode == 200) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tournament updated'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to update tournament');
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update tournament'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
