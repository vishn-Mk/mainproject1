import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainproject1/moduls/auth/login.dart';
import 'package:mainproject1/moduls/player/profile/player_edit_screen.dart';
import 'package:mainproject1/services/db_service.dart';

import 'dart:convert';

import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../player_complaint_list.dart';



class PlayerProfileScreen extends StatelessWidget {
  PlayerProfileScreen({Key? key, required this.loginId}) : super(key: key);

  final String loginId;

  Future<Map<String, dynamic>> _fetchProfileData() async {
    final response = await http
        .get(Uri.parse('$baseUrl/api/player/view-player-profile/$loginId'));

    if (response.statusCode == 200) {
      return json.decode(response.body)["data"][0];
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const  Text('Logout'),
          IconButton(
            onPressed: () {
              
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
              // Logout logic
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchProfileData(),
        builder: (context, snapshot) {


          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final profileData = snapshot.data!;

            print(profileData);
            return Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 100,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(height: 30),
                  Text('Name: ${profileData['name']}'),
                  const SizedBox(height: 20),
                  Text('Age: ${profileData['age']}'),
                  const SizedBox(height: 20),
                  Text('Position: ${profileData['position']}'),
                  const SizedBox(height: 30),
                  Text('Phone: ${profileData['mobile']}'),
                  const SizedBox(height: 30),

                  Spacer(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Edit',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerEditProfileScreen(name: profileData['name'],age: profileData['age'],position: profileData['position'],phone: profileData['mobile']),
                                  ));
                            },
                          ),
                        ),

                      SizedBox(width: 20,),
                        Expanded(

                          child: CustomButton(
                            text: 'Complaint',
                            onPressed: () {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerComplaintListScreen(


                              ),));


                            },
                          ),
                        ),


                      ],
                    ),
                  )
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Edit button logic
                  //   },
                  //   child: const Text('Edit'),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
