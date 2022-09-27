import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_app_flutter/Resources/jitsi_meet_methods.dart';
import 'package:zoom_app_flutter/Screen/video_call_screen.dart';
import 'package:zoom_app_flutter/Utils/color.dart';
import 'package:zoom_app_flutter/Widget/home_meeting_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 100000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVedioMuted: true);
  }

  joinMeeting(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => VideoCallScreen())));
  }

  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meet and Chat"),
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HomeMeetingButton(
                  icon: Icons.videocam_rounded,
                  text: "New Meeting",
                  onTap: createNewMeeting),
              HomeMeetingButton(
                  icon: Icons.add_box_rounded,
                  text: "Join Meeting",
                  onTap: () => joinMeeting(context)),
              HomeMeetingButton(
                  icon: Icons.calendar_today_outlined,
                  text: "Schedule",
                  onTap: () {}),
              HomeMeetingButton(
                  icon: Icons.ios_share_rounded,
                  text: "Share screen",
                  onTap: () {})
            ],
          ),
          const Expanded(
              child: Center(
            child: Text(
              "Create/Join meeting with just a click",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          onTap: (val) {
            setState(() {
              _page = val;
            });
          },
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded), label: "Meet & Chat"),
            BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Meetings"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined), label: "Contacts"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.chat_bubble_sharp), label: "Meetings History")
          ]),
    );
  }
}
