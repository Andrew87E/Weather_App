import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'favorites_screen.dart';
import 'search.dart';

final List<Map<String, dynamic>> pageDetails = [
  {
    'pageName': HomeScreen(
      bgColor: Colors.white38,
    ),
    'title': 'Home',
    'navigationBarColor': Colors.lightGreen.shade500,
    'bottom_color': Colors.lightGreen.shade200
  },
  {
    'pageName': FavoritesScreen(
      bgColor: Colors.white38,
    ),
    'title': 'Favorites',
    'navigationBarColor': Colors.orange.shade500,
    'bottom_color': Colors.orange.shade200
  },
  {
    'pageName': SearchScreen(
      bgColor: Colors.white38,
    ),
    'title': 'Home',
    'navigationBarColor': Colors.lightBlue.shade500,
    'bottom_color': Colors.lightBlue.shade200
  },
];
