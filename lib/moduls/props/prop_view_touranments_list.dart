import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/props/prop_added_tourenament_details.dart';

import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';


class PropViewTouranmentsScreen extends StatefulWidget {
  const PropViewTouranmentsScreen({Key? key}) : super(key: key);

  @override
  State<PropViewTouranmentsScreen> createState() =>
      _PropViewTouranmentsScreenState();
}

class _PropViewTouranmentsScreenState extends State<PropViewTouranmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 11, 9, 9)),
          title: const Text('Your Ticket'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent('upcoming'),
            _buildTabContent('completed'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String status) {
    return FutureBuilder(
      future: ApiService().fetchUpcomingTournaments(status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return indicator;
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
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
                        builder: (context) => PropTournamentsDetailsScreen(
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
                          builder: (context) => PropTournamentsDetailsScreen(
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
    );
  
  
  
  }
}
