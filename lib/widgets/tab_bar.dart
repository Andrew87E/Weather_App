import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'tab_map.dart';

class AeNav extends StatefulWidget {
  const AeNav({super.key});

  @override
  State<AeNav> createState() => _TabBarState();
}

class _TabBarState extends State<AeNav> {
  final int _activePageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _activePageIndex,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
        items: const <Widget>[
          Icon(Icons.home_outlined),
          Icon(Icons.favorite_outline),
          Icon(Icons.search_outlined),
          Icon(Icons.verified_user),
        ],
      ),
    );
  }
}
