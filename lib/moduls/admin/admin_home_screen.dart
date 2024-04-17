import 'package:flutter/material.dart';
import 'package:mainproject1/moduls/admin/view_booking_list.dart';
import 'package:mainproject1/moduls/admin/view_props_screen.dart';
import 'package:mainproject1/moduls/admin/view_users_screen.dart';
import 'package:mainproject1/moduls/admin/widgets/card_widgets.dart';

import 'add_price_list.dart';
import 'add_turf_screen.dart';
import 'admin_approve_props.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: GridView.count(crossAxisCount: 2, children: [
          CardWidget(
            iconData: Icons.approval_outlined,
            title: 'Approve props',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminApprovpPrpops(),
                  ));
            },
          ),
          CardWidget(
            iconData: Icons.apps,
            title: 'View props',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewPrpopsScreen(),
                  ));
            },
          ),
          CardWidget(
            iconData: Icons.group,
            title: 'View users',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewUsersScreen(),
                ),
              );
            },
          ),
          CardWidget(
            iconData: Icons.price_check,
            title: 'Add price list',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddPriceScreen(),
                  ));
            },
          ),
          CardWidget(
            iconData: Icons.bookmark_add,
            title: 'View  booking',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewBookingList(),
                  ));
            },
          ),
          CardWidget(
            iconData: Icons.add,
            title: 'Add turf',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  AddTurfScreen(),
                  ));
            },
          ),
        ]),
      ),
    );
  }
}
