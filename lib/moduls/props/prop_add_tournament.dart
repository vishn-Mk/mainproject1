import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class PropAddTournamentsScreen extends StatefulWidget {
  const PropAddTournamentsScreen({Key? key}) : super(key: key);

  @override
  State<PropAddTournamentsScreen> createState() =>
      _PropAddTournamentsScreenState();
}

class _PropAddTournamentsScreenState extends State<PropAddTournamentsScreen> {
  String? emailError;
  String? passwordError;
  bool _obscureText = true;




  final _nameControllers = TextEditingController();
  final _winpriceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalTicketController = TextEditingController();
  final _ticketPriceController = TextEditingController();




  DateTime? _selectedDate;
  bool _loading = false;
  TimeOfDay ? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040)
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose

   

  _nameControllers.dispose();
  _winpriceController.dispose();
  _descriptionController.dispose();
  _totalTicketController.dispose();
 _ticketPriceController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Tournaments',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                hintText: 'Enter name',
                controller: _nameControllers,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter price',
                controller: _winpriceController,
                input: TextInputType.number,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter description',
                controller: _descriptionController,
                minLength: 6,
                maxLength: 15,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Total tickets',
                controller: _totalTicketController,
                input: TextInputType.number,
                borderColor: Colors.grey,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Ticket price',
                controller: _ticketPriceController,
                input: TextInputType.number,
                borderColor: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select Date'),

                  // CustomButton(text: 'select', onPressed: () {
                  //   _selectDate(context);
                  // },)
                  _selectedDate == null
                      ? CustomButton(
                          text: 'select',
                          onPressed: () {
                            _selectDate(context);
                          },
                        )
                      : Text(DateFormat('dd-MMM-yy').format(_selectedDate!))
                ],
              ),
              const SizedBox(
                height: 20,
              ),


              Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '${_selectedTime?.format(context) ?? 'Select a time'}',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        CustomButton(
          onPressed: () async {
            final TimeOfDay ? picked = await showTimePicker(
              context: context,
              initialTime: _selectedTime ?? TimeOfDay.now(),
            );
            if (picked != null) {
              
              setState(() {
                _selectedTime = picked;
              });

              
             
            }
          },
          text: _selectedTime != null ? 'change'  :'Select Time',
        ),
      ],
    ),
              _loading ?  indicator    :SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomButton(
                  text: 'ADD',
                  onPressed: () {
                    _addTouranment(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addTouranment(BuildContext context) async {
    if (emailError == null &&
        passwordError == null &&
        _nameControllers.text.isNotEmpty &&
        _winpriceController.text.isNotEmpty && _selectedDate != null) {
      var params = {
        'tournament_name': _nameControllers.text,
        'win_price':  _winpriceController.text,
        'description': _descriptionController.text,
        'total_tickets': _totalTicketController.text,
        'ticket_price': _ticketPriceController.text,
        'time' : '${_selectedDate!.hour}:${_selectedDate!.minute}',
        'date': DateFormat('MM/dd/yyyy').format(_selectedDate!)
      };

      try {

        setState(() {
          _loading = true;
        });
        var response = await http.post(
          Uri.parse('https://vadakara-mca-turf-backend.onrender.com/api/proprietor/add-tournament'),
          body: params,
         
        );

        var data = jsonDecode(response.body);

         
        if (response.statusCode == 200) {


          _descriptionController.clear();
          _nameControllers.clear();
          _ticketPriceController.clear();
          _totalTicketController.clear();
          _selectedDate = null;
          _winpriceController.clear();

          if(context.mounted){
            customSnackBar(context: context, messsage:data['Message']);
          }

          setState(() {
            _loading = false;
          });
          
        } else {
          if(context.mounted){
            customSnackBar(context: context, messsage:data['Message']);
          }
          setState(() {
            _loading = false;
          });

         
        }
      } catch (e) {
        if(context.mounted){
          customSnackBar(context: context, messsage:'Somthing went wrong');
        }
        setState(() {
          _loading = false;
        });
        
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
      setState(() {});
    }
  }
}
