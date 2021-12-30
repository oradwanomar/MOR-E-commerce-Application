import 'dart:ui';
import 'package:mor_app/screens/empty_cart.dart';
import 'package:mor_app/screens/search.dart';
import 'package:mor_app/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'cart.dart';
import 'feeds.dart';
import 'home.dart';
import 'package:mor_app/consts/theme_data.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBar';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomeScreen(),
      },
      {
        'page': FeedsScreen(),
      },
      {
        'page': SearchScreen(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfo(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: CurvedNavigationBar(
        // ignore: deprecated_member_use
        color: Theme.of(context).bottomAppBarColor,
        buttonBackgroundColor: Colors.orange[400],
        animationCurve: Curves.bounceInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: _selectPage,
        backgroundColor: Colors.transparent,
        index: _selectedPageIndex,
        items: [
          Icon(
            (_selectedPageIndex == 0) ? Ionicons.home_outline : Ionicons.home,
            size: 22,
            color: (_selectedPageIndex == 0)
                ? Colors.white
                // ignore: deprecated_member_use
                : Theme.of(context).textSelectionColor,
          ),
          Icon(
            Icons.rss_feed,
            size: 22,
            color: (_selectedPageIndex == 1)
                ? Colors.white
                : Theme.of(context).textSelectionColor,
          ),
          Icon(
            Ionicons.search,
            size: 28,
            color: (_selectedPageIndex == 2)
                ? Colors.white
                : Theme.of(context).textSelectionColor,
          ),
          Icon(
            (_selectedPageIndex == 3)
                ? Icons.shopping_bag_outlined
                : Icons.shopping_bag,
            size: 22,
            color: (_selectedPageIndex == 3)
                ? Colors.white
                : Theme.of(context).textSelectionColor,
          ),

          Icon(
            (_selectedPageIndex == 4)
                ? Ionicons.person_outline
                : Ionicons.person,
            size: 22,
            color: (_selectedPageIndex == 4)
                ? Colors.white
                : Theme.of(context).textSelectionColor,
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.rss_feed),
          //   label: 'Feeds',
          // ),
          // BottomNavigationBarItem(
          //   activeIcon: null,
          //   icon: Icon(null),
          //   label: 'Search',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.shopping_bag,
          //   ),
          //   label: 'Cart',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'User',
          // ),
        ],
      ),
    );
    // floatingActionButtonLocation:
    //     FloatingActionButtonLocation.miniCenterDocked,
    // floatingActionButton: Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: FloatingActionButton(
    //     focusColor: Colors.purple,
    //     hoverColor: Colors.purple,
    //     foregroundColor: Colors.white,
    //     backgroundColor: Colors.purple,
    //     hoverElevation: 10,
    //     splashColor: Colors.grey,
    //     tooltip: 'Search',
    //     elevation: 4,
    //     child: Icon(Icons.search),
    //     onPressed: () => setState(() {
    //       _selectedPageIndex = 2;
    //     }),
    //   ),
  }
}
