
import 'package:flutter/material.dart';

import '../../../services/api_service.dart';
import '../../../services/db_service.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';


class PlayerEditProfileScreen extends StatefulWidget {
  PlayerEditProfileScreen({super.key, required this.name, required this.age, required this.position, required this.phone});

  final String name;
  final String age;
  final String position;
  final String phone;

  @override
  State<PlayerEditProfileScreen> createState() => _PlayerEditProfileScreenState();
}

class _PlayerEditProfileScreenState extends State<PlayerEditProfileScreen> {
final TextEditingController _nameController = TextEditingController();

final TextEditingController _phoneController = TextEditingController();

final TextEditingController _postionController = TextEditingController();

final TextEditingController _ageController = TextEditingController();

bool loading =  false;
@override
  void initState() {
    _nameController.text = widget.name;
    _phoneController.text = widget.phone;
    _postionController.text = widget.position;
    _ageController.text = widget.age;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit Profile'),),
      body: loading ?  Center(child: CircularProgressIndicator(),) : Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              const CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                  ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  hintText: 'name',
                  controller: _nameController,
                  
                  borderColor: Colors.grey.shade500,
                ),
              ),
               const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  hintText: 'age',
                  controller: _ageController,
                  
                  borderColor: Colors.grey.shade500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  hintText: 'position',
                  controller: _postionController,
                  borderColor: Colors.grey.shade500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextField(
                  hintText: 'phone',
                  controller: _phoneController,
                  borderColor: Colors.grey.shade500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'Confirm',
                  color: Colors.teal,
                  onPressed: () async{
                    try{

                      setState(() {
                        loading = true;
                      });

                    


                     await ApiService().updatePlayerProfile(
                        context: context,
                        loginId: DbService.getLoginId()!,
                        age:  _ageController.text,
                        name: _nameController.text,
                        mobile: _phoneController.text,
                        postion: _postionController.text

                        
                      );

                      Navigator.pop(context);

                      setState(() {
                        loading = false;
                      });

                    }catch(e){

                      setState(() {
                        loading = false;
                      });


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
}