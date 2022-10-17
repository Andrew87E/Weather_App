import 'package:flutter/material.dart';
import '../tab_bar.dart';

class AeHomeScreen extends StatefulWidget {
  const AeHomeScreen({Key? key, Color? bgColor}) : super(key: key);

  @override
  State<AeHomeScreen> createState() => _AeHomeScreenState();
}

class _AeHomeScreenState extends State<AeHomeScreen> {
  String btnName = 'Click Me';

  Color btnColor = Colors.black;

  void changeBtnColor() {
    if (btnColor == Colors.black) {
      btnColor = const Color.fromARGB(255, 10, 191, 227);
    } else {
      btnColor = const Color.fromARGB(255, 0, 0, 0);
    }
  }

  void btnPress() {
    if (btnName == 'Click Me') {
      setState(() {
        btnName = 'Clicked';
      });
      changeBtnColor();
    } else {
      setState(() {
        btnName = 'Click Me';
      });
      changeBtnColor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text('My First App'),
        )),
        body: Center(
            child: ElevatedButton(
          onPressed: (() {
            btnPress();
          }),
          child: const Text('Press'),
        )),
        bottomNavigationBar: const AeNav());
  }
}
