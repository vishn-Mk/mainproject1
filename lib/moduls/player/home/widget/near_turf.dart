import 'package:flutter/material.dart';

import '../../../../services/api_service.dart';
import '../../../../utils/constants.dart';
import '../turf_details.dart';


class NearTurfWidget extends StatelessWidget {
  const NearTurfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: ApiService().fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return indicator;
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var turfList = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                turfList!.length,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerTurfDetailsScreen(
                          turfDetails: turfList[
                              index], // Assuming 'image' is the key for the image URL
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(10),
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
                            turfList[index]['images'][
                                0], // Assuming 'image' is the key for the image URL
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          turfList[index][
                              'turf_name'], // Assuming 'name' is the key for the turf name
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
