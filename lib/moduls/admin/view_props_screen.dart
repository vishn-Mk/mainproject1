import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/admin/widgets/props_details_widget.dart';


class ViewPrpopsScreen extends StatelessWidget {
  const ViewPrpopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Props',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Card(
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1675662138817-89c6139baabd?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dHVyZnxlbnwwfHwwfHx8MA%3D%3D'), // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text(
                      'name',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PropsDetailsWidget(),
                          ));
                    },
                  ),
                )),
      ),
    );
  }
}
