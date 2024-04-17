import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/public/public_user_complaints.dart';
import 'package:mainproject1/moduls/public/public_user_tournamentsDetails.dart';

import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';


class PublicViewTouranmentsScreen extends StatefulWidget {
  const PublicViewTouranmentsScreen({super.key});

  @override
  State<PublicViewTouranmentsScreen> createState() =>
      _PublicViewTouranmentsScreenState();
}

class _PublicViewTouranmentsScreenState
    extends State<PublicViewTouranmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PublicUserComplaints(),
              ),
            );
          },
          text: 'Add Complaints',
        ),
      ),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 11, 9, 9)),
            title: const Text('Your Ticket'),
            centerTitle: true,
          ),
          Expanded(
              child: FutureBuilder(
            future: ApiService().fetchUpcomingTournaments('upcoming'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return indicator;
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: ListTile(
                        onTap: () async {
                          bool ref = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PublicTournamentsDetailsScreen(
                                tournamentDetails: snapshot.data![index],
                              ),
                            ),
                          );

                          if (ref) {
                            setState(() {});
                          }
                        },
                        trailing: CustomButton(
                          onPressed: () async {
                            bool ref = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PublicTournamentsDetailsScreen(
                                  tournamentDetails: snapshot.data![index],
                                ),
                              ),
                            );

                            if (ref) {
                              setState(() {});
                            }
                          },
                          text: 'more',
                        ),
                        leading: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                          ),
                        ),
                        title: Text(
                          snapshot.data![index]['tournament_name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )),
        ],
      ),
    );
  }
}
