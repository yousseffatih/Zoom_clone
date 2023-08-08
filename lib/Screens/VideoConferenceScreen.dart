import 'package:flutter/material.dart';
import 'package:zoom_clone/variables.dart';
import 'package:zoom_clone/videoconference/createMeeting.dart';
import 'package:zoom_clone/videoconference/joingmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  const VideoConferenceScreen({super.key});

  @override
  State<VideoConferenceScreen> createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  buildTab(String name) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            name,
            style: mystyle(15, Colors.black, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: Text(
          "ZOOM Clone",
          style: mystyle(20, Colors.white, FontWeight.w700),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [buildTab("Join Meeting"), buildTab("Create Meeting")],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          JoingMeeting(),
          createMeeting(),
        ],
      ),
    );
  }
}
