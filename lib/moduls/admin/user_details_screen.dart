import 'package:flutter/material.dart';

import '../../widgets/column_card.dart';


class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key, required this.user});


  final Map<String, dynamic> user;


   @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:  Text(
          user['name'],
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(user["photo"]),
              radius: 50,
            ),
            const SizedBox(height: 16),
            Text(
              user["name"],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColumnCardWidgets(text: 'Phone',),
                        Text('123456789'),
                        SizedBox(height: 10,),
                        ColumnCardWidgets(text: 'Email',),
                        Text('aas@gmail.com'),
                        SizedBox(height: 10,),
                                
                      ],
                    ),
                  ),
                ),
            // Add more profile details here
          ],
        ),
      ),
    );
  }
}