import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/auth/player_registration_screen.dart';
import 'package:mainproject1/moduls/auth/prop_registration_screen.dart';


class ChooseRegistrationScreen extends StatelessWidget {
  const ChooseRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teal Containers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerRegistrationScreen(),
                  ),
                );
              },
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sports_handball,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Player',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PropRegistrationScreen(),
                  ),
                );
              },
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 50,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Proprator',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
