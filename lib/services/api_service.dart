import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'api_end_points.dart';
import 'db_service.dart';


class ApiService {
  Future<void> registerProprietor(
      {required String name,
      required String email,
      required String mobile,
      required String age,
      required String address,
      required String password}) async {
    var url = Uri.parse(ApiEndoint.baseUrl + ApiEndoint.propReg);
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var body = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'age': age,
      'address': address,
      'password': password
    };

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        throw Exception(
            'Failed to register proprietor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to register proprietor');
    }
  }

  Future<List<dynamic>> fetchUpcomingTournaments(String status) async {
    var url = Uri.parse('$baseUrl/api/proprietor/view-$status-tournaments');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('No data');
    }
  }

  Future<List<dynamic>> fetchData() async {
    var url = Uri.parse('$baseUrl/api/user/view-turf');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addRequest(
      {required String loginId,
      required String date,
      required String spot,
      required String mobile,
      required String time,
      required String position,
      required BuildContext context}) async {
    try {
      // Show loading snack bar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Adding Request..."),
            ],
          ),
        ),
      );

      final response = await http.post(
        Uri.parse('$baseUrl/api/player/add-request'),
        body: {
          'login_id': DbService.getLoginId(),
          'date': date,
          'spot': spot,
          'mobile': mobile,
          'time': time,
          'position': position,
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Request successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success'),
          ),
        );
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Exception occurred: '),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Faild'),
        ),
      );
    }

  }





    Future<void> updatePlayerProfile({
      
      required BuildContext context,
      required String loginId,
      required  String age,
      required String mobile,
      required String name,
      required String postion, 
      }) async {
      final url = '$baseUrl/api/player/update-player-profile/${DbService.getLoginId()}';

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Updating Profile..."),
              ],
            ),
          ),
        );
        print('gggg');

        final uri = Uri.parse(url);

        print(uri);
        final response = await http.post(uri,body:  {
          'name': name,
          'mobile': mobile,
          'age': age,
          'position': postion
        });

        print(response.body);

        if (response.statusCode == 200) {

          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                
                Text("Success!!!!"),
              ],
            ),
          ),
        );
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                
                Text("fail!!!!"),
              ],
            ),
          ),
        );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                
                Text("Fail"),
              ],
            ),
          ),
        );
      }
    }


  Future<void> addPartnerRequest(String loginId, String requestId) async {
    final url = Uri.parse('${baseUrl}/api/player/add-request');

    try {
      final response = await http.post(
        url,
        body: {
          'login_id': loginId,
          'request_id': requestId,
        },

      );
     print(response.body);
      if (response.statusCode == 200) {
        // Request successful, handle response if needed
      } else {
        throw Exception('Failed to add request: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to add request: $e');
    }
  }



  
  
}
