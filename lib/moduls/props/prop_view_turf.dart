import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/props/prop_turf_details.dart';

import '../../services/api_service.dart';
import '../../utils/constants.dart';


class PropsTurfScreen extends StatelessWidget {
  PropsTurfScreen({super.key});

  final turfList = [
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
    'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
          future: ApiService().fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return indicator;
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              print(snapshot.data);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: List.generate(
                      snapshot.data!.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PropTurfDetailsScreen(
                                turfDetails:snapshot.data![index] 
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.shade200)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(

                                  snapshot.data![index]['images'][0],

                                  fit: BoxFit.fill,
                                  height: 150,
                                  width: 150,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data![index]['turf_name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data![index]['address'],
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              );
            }
          }),
    );
  }
}
