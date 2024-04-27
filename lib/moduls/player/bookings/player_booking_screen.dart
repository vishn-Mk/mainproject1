import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

import '../../../services/db_service.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_button.dart';
import '../../payment_screen.dart';
import '../player_root_screen.dart';

class PlayerTurfBookingScreen extends StatefulWidget {
  const PlayerTurfBookingScreen(
      {super.key, required this.images, required this.price});

  final String images;
  final int price;

  @override
  State<PlayerTurfBookingScreen> createState() =>
      _PlayerTurfBookingScreenState();
}

class _PlayerTurfBookingScreenState extends State<PlayerTurfBookingScreen> {
  DateTime _selectedValue = DateTime.now();

  int _selectedIndex = 0;

  bool loading = false;

  List<Map<String, dynamic>> bookings = [];

  Future<void> fetchBookings() async {
    setState(() {
      loading = true;
    });

    String date = DateFormat('M/DD/yyyy').format(DateTime.now());

    print(date);

    final response = await http.post(
      Uri.parse('$baseUrl/api/player/view-bookings-by-date'),
      body: {"date": date},
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['Success']) {
        setState(() {
          bookings = List<Map<String, dynamic>>.from(jsonData['data']);
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
      throw Exception('Failed to load bookings');
    }
  }

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
        startTimeFormatted = formatTime(startTime);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != startTime) {
      setState(() {
        endTime = picked;
        endTimeFormatted = formatTime(endTime);

        getTotal(
          startTime: startTime,
          endTime: endTime,
        );
      });
    }
  }

  int? total;

  bool load=false;

  void getTotal({required TimeOfDay startTime, required TimeOfDay endTime}) {
    DateTime startDateTime =
        DateTime(1, 1, 1, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(1, 1, 1, endTime.hour, endTime.minute);

    int def = endDateTime.difference(startDateTime).inHours;

    print(def);

    setState(() {
      total = def * widget.price;
    });
  }

  String? startTimeFormatted;
  String? endTimeFormatted;

  @override
  void initState() {
    total = widget.price;

    startTimeFormatted = formatTime(startTime);
    endTimeFormatted = formatTime(endTime);
    // TODO: implement initState
    fetchBookings();
    super.initState();
  }

  String formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.6,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.images,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booked slot',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            )
                          : bookings.isNotEmpty
                              ? SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: bookings.length,
                                    itemBuilder: (context, index) {
                                      final booking = bookings[index];
                                      return Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: ListTile(
                                          leading: Text(
                                              'start${booking['start_time']}'),
                                          trailing:
                                              Text('end${booking['end_time']}'),
                                        ),
                                      );
                                    },
                                  ))
                              : const Center(
                                  child: Text('You can book any time'),
                                ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DatePicker(
                        DateTime.now(),
                        height: 100,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Colors.teal,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {
                          // New date selected
                          setState(() {
                            _selectedValue = date;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(startTimeFormatted!),
                          const Spacer(),
                          CustomButton(
                            text: 'select start Time',
                            onPressed: () {
                              _selectStartDate(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(endTimeFormatted!),
                          const Spacer(),
                          CustomButton(
                            text: 'select end Time',
                            onPressed: () {
                              _selectEndDate(context);
                            },
                          ),
                        ],
                      ),
                      const Center(
                        child: Text(
                          'Grand Total',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          '₹$total',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CustomButton(
                                text: 'Proceed',
                                onPressed: () async{
                                  String formatSelectedDate =
                                      DateFormat('M/dd/yyyy')
                                          .format(_selectedValue);

                                          if(total! > 0){


                                          if(load)
                                            {
                                              bookTurf(
                                                  DbService.getLoginId()!,
                                                  formatSelectedDate,
                                                  startTimeFormatted!,
                                                  endTimeFormatted!,
                                                  total.toString()
                                              );
                                            }else{
                                            load=await   Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(totalAmount: total.toString(),),));


                                          }


                                          }else{


                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correct your start time and end time')));
                                          }

                                  
                                },
                              ),
                            )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> bookTurf(
      String loginId, String date, String startTime, String endTime,String total) async {
    try {
      setState(() {
        loading = true;
      });
      final response = await http.post(
        Uri.parse('$baseUrl/api/player/book-turf'),
        body: {
          "login_id": loginId,
          "date": date,
          "start_time": startTime,
          "end_time": endTime,
          "total" : total
        },
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            confirmBtnColor: Colors.teal,
            onConfirmBtnTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerRootScreen(),
                  ),
                  (route) => false);
            },
          );
        }

        setState(() {
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });

        if (context.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            confirmBtnColor: Colors.teal,
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
          );
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      if (context.mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          confirmBtnColor: Colors.teal,
          onConfirmBtnTap: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }
}
