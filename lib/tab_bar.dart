import 'package:flutter/material.dart';

import './tabs/tab_map.dart';

class AeNav extends StatefulWidget {
  const AeNav({super.key});

  @override
  State<AeNav> createState() => _TabBarState();
}

class _TabBarState extends State<AeNav> {
  int _activePageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: pageDetails[_activePageIndex]['title']),
      body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _activePageIndex = index;
            });
          },
          children: [
            pageDetails[0]['pageName'],
            pageDetails[1]['pageName'],
            pageDetails[2]['pageName'],
            pageDetails[3]['pageName'],
          ]),
    );
  }
}
