import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';


class AddTurfScreen extends StatefulWidget {
  const AddTurfScreen({super.key});

  @override
  State<AddTurfScreen> createState() => _AddTurfScreenState();
}

class _AddTurfScreenState extends State<AddTurfScreen> {
  final turfNameController = TextEditingController();

  final _turfAddressController = TextEditingController();

  final _turfhoneNumberController = TextEditingController();

  final _chargeController = TextEditingController();

  String dropdownValue = 'indoor';
  String dropDownCatValue = 'football';
  bool  loading  = false;
  File ? turfImage;

  @override
  void dispose() {
    turfNameController.dispose();
    _turfAddressController.dispose();
    _turfhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(height: 20,);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add turf',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Column(
            children: [
              CustomTextField(
                  hintText: 'Turf Name', controller: turfNameController),
              sizedBox,
              CustomTextField(
                  hintText: 'Turf Address', controller: _turfAddressController,),
                  sizedBox,
              CustomTextField(
                  hintText: 'Phone', controller: _turfhoneNumberController,),
                sizedBox,
              
              CustomTextField(hintText: 'Charge', controller: _chargeController,),
              sizedBox,
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Type'),
                  DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['indoor', 'outdoor']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
                ],
              ),

              sizedBox,
        
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Category'),
                  DropdownButton<String>(
                  value: dropDownCatValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownCatValue = newValue!;
                    });
                  },
                  items: <String>['football', 'cricket','tennis']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
                ],
              ),

              sizedBox,
             
             
             
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add image'),
                  turfImage != null ?Container(
                    height: 100,
                    width: 100,
                    child: Image.file(turfImage!,fit: BoxFit.cover,) ,
                  ) :  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () async {
                      
                      turfImage =  await _getImage(ImageSource.gallery);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              sizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add leagal document'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {},
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'Add', onPressed: (){
              
                }),
              )
           
           
            ],
          ),
        ),
      ),
    );
  }



  Future<File> _getImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile != null) {
    print(pickedFile.path);

    return File(pickedFile.path);

  } else {
    throw Exception('No image');
  }
}
}
