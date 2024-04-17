import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/player/home/widget/near_turf.dart';

import '../../../services/api_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../bookings/player_ticket_booking.dart';
import '../partner/player_request_screen.dart';


class PlayerHomeScreen extends StatefulWidget {
  const PlayerHomeScreen({super.key});

  @override
  State<PlayerHomeScreen> createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  final _tournamentsList = [
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
                const Text(
                  'Find your Arena',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: 'Request for partner',
                      color: Colors.white,
                      textColor: Colors.teal,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PlayerRequestScreen(),
                          ),
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Our service',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
                child: NearTurfWidget(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Tournaments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            FutureBuilder<List<dynamic>>(
  future:  ApiService().fetchUpcomingTournaments('upcoming'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return indicator;
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else {
      List<dynamic> tournaments = snapshot.data ?? [];
      return SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              tournaments.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerTournamentsDetailsScreen(
                        tournamentDetails: tournaments[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                          fit: BoxFit.fill,
                          height: 120,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              tournaments[index]['date'],
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              tournaments[index]['tournament_name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  },
),

            
            
            ],
          ),
        ))
      ],
    );
  }


  
}

