import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String btnName = 'Click Me';
  int value = 0;
  Color btnColor = Colors.black;

  void changeBtnColor() {
    if (btnColor == Colors.black) {
      btnColor = Color.fromARGB(255, 10, 191, 227);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text('My First App'),
        )),
        body: Center(
            child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                  onPressed: btnPress,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red,
                    backgroundColor: btnColor,
                  ),
                  child: Text(btnName)),
              ElevatedButton(onPressed: btnPress, child: Text(btnName)),
            ],
          ),
        )),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: value,
          onTap: (int value) {
            setState(() {
              value = value;
            });
          },
        ),
      ),
    );
  }
}
