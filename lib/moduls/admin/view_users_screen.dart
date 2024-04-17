import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/admin/user_details_screen.dart';


class ViewUsersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> profiles = [
    {"name": "John Doe", "photo": "https://via.placeholder.com/150"},
    {"name": "Jane Smith", "photo": "https://via.placeholder.com/150"},
    // Add more profiles as needed
  ];

   ViewUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [

          SizedBox(height: 10,),

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 10,),
              itemCount: profiles.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(profiles[index]["photo"]),
                  ),
                  title: Text(profiles[index]["name"]),
                  trailing: const Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(user: profiles[index],),));
                    
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}