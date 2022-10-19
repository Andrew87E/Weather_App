import 'package:basic_app/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String city = "";
  final GlobalController globalController = Get.put(GlobalController());
  String now = DateFormat("yMMMMd").format(DateTime.now());

  @override
  void initState() {
    getAddress(
        globalController.getLat().value, globalController.getLong().value);
    super.initState();
  }

  getAddress(lat, long) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            now,
            style: GoogleFonts.rubik(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
