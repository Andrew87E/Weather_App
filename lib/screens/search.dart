import 'package:flutter/material.dart';
import '../widgets/tab_bar.dart';

class SearchScreen extends StatelessWidget {
  Color bgColor;
  SearchScreen({
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
