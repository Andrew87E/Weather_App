import 'package:flutter/material.dart';
import '../tab_bar.dart';

class HomeScreen extends StatelessWidget {
  Color bgColor;
  HomeScreen({
    Key? key,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
    );
  }
}
