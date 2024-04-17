import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:mainproject1/services/db_service.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class playercomplaint extends StatefulWidget {
  const playercomplaint({super.key});

  @override
  State<playercomplaint> createState() => _PublicUserComplaintsState();
}

class _PublicUserComplaintsState extends State<playercomplaint> {
  final _controller = TextEditingController();
  final _mobileController = TextEditingController();
  final _title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add Complaints',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'Add title',
                controller: _title,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: 'Add complaints',
                  maxLength: 20,
                  minLength: 6,
                  controller: _controller),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'Submit',
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {
                    if(_controller.text.isEmpty && _title.text.isEmpty &&  _mobileController.text.isEmpty){

                    }else{

                      addComplaint(
                        _title.text,
                        _controller.text,
                        context,
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addComplaint(String title, String complaint,
      BuildContext context) async {
    final url = Uri.parse('$baseUrl/api/user/add-complaint');
    final body = {
      'login_id': DbService.getLoginId(),
      'title': title,
      'complaint': complaint,
    };
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    try {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Adding complaint...'),
      ));

      final response = await http.post(
        url,
        body: body,
        headers: headers,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Complaint added successfully'),
        ));
      } else {
        throw Exception(
            'Failed to add complaint. Status code: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add complaint: $e'),
      ));
    }
  }


}
