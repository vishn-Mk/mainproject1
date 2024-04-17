import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/player/partner/player_partner_screen.dart';
import 'package:mainproject1/moduls/player/profile/player_profile_screen.dart';

import '../../services/db_service.dart';
import 'bookings/player_booking_list_screen.dart';
import 'bookings/player_ticket_booking_list.dart';
import 'home/player_home_screen.dart';


class PlayerRootScreen extends StatefulWidget {
  const PlayerRootScreen({super.key});

  @override
  State<PlayerRootScreen> createState() => _PlayerRootScreenState();
}

class _PlayerRootScreenState extends State<PlayerRootScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _pagesList =  [
    const PlayerHomeScreen(),
    const PlayerPartnerScreen(),
     PlayerBookingListScreen(loginId: DbService.getLoginId()!,),
    const PlayerTicketListScreen(),
    PlayerProfileScreen(loginId: DbService.getLoginId()!,)
  
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: _pagesList[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
    splashColor: Colors.transparent,
    
  ),

        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          selectedItemColor:  Colors.teal,
          unselectedItemColor: Colors.grey,
          useLegacyColorScheme: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add),
              label: 'Search partner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Tournament ticket',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}