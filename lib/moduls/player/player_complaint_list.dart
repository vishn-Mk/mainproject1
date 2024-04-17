import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/player/playercomplaint.dart';
import 'package:mainproject1/widgets/custom_button.dart';

class PlayerComplaintListScreen extends StatelessWidget {
  const PlayerComplaintListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(itemBuilder: (context, index) {

                return  ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Complaint'),

                );

          },),),
          CustomButton(
              text: 'Add Complaint', onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => playercomplaint(),));

              },)


        ],
      ),
    );
  }
}
