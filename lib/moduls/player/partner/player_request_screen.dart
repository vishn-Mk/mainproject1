import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/api_service.dart';
import '../../../services/db_service.dart';
import '../../../widgets/custom_button.dart';


class PlayerRequestScreen extends StatefulWidget {
  const PlayerRequestScreen({super.key});

  @override
  State<PlayerRequestScreen> createState() => _PlayerRequestScreenState();
}

class _PlayerRequestScreenState extends State<PlayerRequestScreen> {
  String dropdownvalue = 'Football';

// List of items in our dropdown menu
  var items = [
    'Football',
    'Cricket',
    'shuttle',
  ];

  DateTime _selectedValue = DateTime.now();

  TimeOfDay _selectedTime = TimeOfDay.now();

  int _selectedIndex = 0;

  final _postionController = TextEditingController();
  final _phoneController = TextEditingController();
  bool loading = false;

  String ? _selectedItem;


  @override
  void dispose() {
   _postionController.dispose();
   _postionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Request",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body:loading ? const Center(
        child: CircularProgressIndicator(),
      )  : SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    hint: const Text('Select a sport'),
                    value: _selectedItem ?? 'Football',

                    elevation: 0,
                    isExpanded: true,
                    icon: const Icon(Icons.expand_more),
                    iconSize: 30,
                    underline: const SizedBox.shrink(),
                    items: <String>[
                      'Football',
                      'Basketball',
                      'Tennis',
                      'Cricket'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      _selectedItem  =  newValue;
                      setState(() {

                      });

                      // Handle selection here
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _postionController,
                  decoration: InputDecoration(
                    labelText: 'position',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  height: 100,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Time',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null && picked != _selectedTime) {
                          setState(() {
                            _selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${_selectedTime.format(context)}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'Request',
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        await ApiService().addRequest(
                          loginId: DbService.getLoginId()!,
                          date: DateFormat('dd/MM/yyyy').format(_selectedValue),
                          spot: dropdownvalue,
                          mobile: _phoneController.text,
                          time: '${_selectedTime.hour}:${_selectedTime.minute}',
                          position: _postionController.text,
                          context: context,
                        );
                        _phoneController.clear();
                        _postionController.clear();

                        setState(() {
                          loading = false;
                        });
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });

                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
