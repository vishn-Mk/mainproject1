import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mainproject1/services/api_end_points.dart';
import 'package:mainproject1/services/api_service.dart';
import 'package:mainproject1/services/db_service.dart';
import '../../../widgets/custom_button.dart';

class PlayerPartnerScreen extends StatefulWidget {
  const PlayerPartnerScreen({Key? key});

  @override
  State<PlayerPartnerScreen> createState() => _PlayerPartnerScreenState();
}

class _PlayerPartnerScreenState extends State<PlayerPartnerScreen> {
  late Future<List<dynamic>> _futureRequests;

  @override
  void initState() {
    super.initState();
    _futureRequests = fetchRequestsData();
  }

  Future<List<dynamic>> fetchRequestsData() async {
    final response = await http.get(Uri.parse('${ApiEndoint.baseUrl}api/player/view-all-request'));


    if (response.statusCode == 200) {

      return jsonDecode(response.body)['data'];

    } else {
      throw Exception('Failed to load requests data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            'Choose your partner',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _futureRequests,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data!.isEmpty) {
                return Center(child: Text('No requests found.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final request = snapshot.data![index];
                    print(request);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg?cs=srgb&dl=pexels-pixabay-274506.jpg&fm=jpg',
                            fit: BoxFit.fill,
                          ),
                        ),

                        title: Text(
                          request['date'] ?? '',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          request['time'] ?? '',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        trailing: CustomButton(
                          text: 'Accept',
                          onPressed: () {
                            ApiService().addPartnerRequest(DbService.getLoginId()!,request['_id'] );
                            setState(() {

                            });


                          },
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
