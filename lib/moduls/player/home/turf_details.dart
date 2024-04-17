import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../bookings/player_booking_screen.dart';


class PlayerTurfDetailsScreen extends StatefulWidget {
  const PlayerTurfDetailsScreen({super.key, required this.turfDetails});

  final Map<String, dynamic> turfDetails;

  @override
  State<PlayerTurfDetailsScreen> createState() =>
      _PlayerTurfDetailsScreenState();
}

class _PlayerTurfDetailsScreenState extends State<PlayerTurfDetailsScreen> {
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
                widget.turfDetails['images'][0],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            widget.turfDetails['turf_name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '₹${widget.turfDetails['price']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.turfDetails['address'],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 30,
                                ),
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  color: Colors.teal,
                                  size: 30,
                                ),
                                Text(
                                  'per hour',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Call',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.phone,
                            size: 24,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    // const Text(
                    //   'Type',
                    //   style:
                    //       TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    // ),

                    // SizedBox(height: 10,),

                    // Container(

                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 15),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       border: Border.all(color: Colors.grey.shade300)),
                    //   child: const Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(Icons.sports_soccer),
                    //       SizedBox(width: 10,),
                    //       Text(
                    //         'Foot ball',
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold),
                    //       ),

                    //     ],
                    //   ),
                    // ),

                    // ignore: prefer_const_constructors
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'Book now',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerTurfBookingScreen(
                                images: widget.turfDetails['images'][0],
                                price: int.parse(widget.turfDetails['price']),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
