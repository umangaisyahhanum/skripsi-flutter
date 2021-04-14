import 'package:flutter/material.dart';
import 'package:simplilearn/feature/class/page/class_page.dart';
import 'package:simplilearn/feature/enrollemt/page/enrollment_page.dart';
import 'dart:io';

import 'package:simplilearn/feature/home/page/home_page.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<Widget> page = List();
  int _counter;
  int _pageCounter;

  void onTabTapped(int index) {
    print(index.toString());
    if (index < 3) {
      setState(() {
        _counter = index;
        _pageCounter = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _pageCounter = 0;
    page.add(HomePage());
    page.add(ClassPage());
    page.add(EnrollmentPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_pageCounter],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        unselectedItemColor: Colors.grey,
        currentIndex: _counter,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "Class",
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Enrollment",
          ),
        ],
      ),
    );
  }
}
