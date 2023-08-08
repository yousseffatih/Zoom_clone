import 'package:flutter/material.dart';
import 'package:zoom_clone/variables.dart';

import 'ProfielScreen.dart';
import 'VideoConferenceScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List PageOptions = [
    VideoConferenceScreen(),
    ProfielScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: mystyle(17, Colors.blue),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: mystyle(17, Colors.black),
        currentIndex: page,
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Video Call",
            icon: Icon(
              Icons.video_call,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ],
      ),
      body: PageOptions[page],
    );
  }
}
