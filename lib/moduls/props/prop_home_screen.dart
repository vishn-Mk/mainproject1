import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/props/prop_add_tournament.dart';
import 'package:mainproject1/moduls/props/prop_booking_screen.dart';
import 'package:mainproject1/moduls/props/prop_view_touranments_list.dart';
import 'package:mainproject1/moduls/props/prop_view_turf.dart';
import 'package:mainproject1/moduls/props/props_allplayer_view_list.dart';

import '../auth/login.dart';


class PropsHomePage extends StatelessWidget {
  const PropsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: Colors.teal,
              child: ListTile(
                leading:
                    const Icon(Icons.app_registration, color: Colors.white),
                title: const Text('Add Touranament',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PropAddTournamentsScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.grass, color: Colors.white),
                title: const Text('View turfs',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PropsTurfScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.festival, color: Colors.white),
                title: const Text('View Tournaments',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PropViewTouranmentsScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.white),
                title: const Text('Booking',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PropBookingListScreen(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.aod, color: Colors.white),
                title: const Text('Ticket bookings',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PropBookingListScreen(),
                    ),
                  );
                },
              ),
            ),

            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text('View all players',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PropsAllPlayersList(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.teal,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
