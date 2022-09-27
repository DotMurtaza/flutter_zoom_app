import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_app_flutter/Resources/auth_method.dart';
import 'package:zoom_app_flutter/Resources/jitsi_meet_methods.dart';
import 'package:zoom_app_flutter/Utils/color.dart';
import 'package:zoom_app_flutter/Widget/custom_button.dart';
import 'package:zoom_app_flutter/Widget/meeting_tiles.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  AuthMethod _authMethod = AuthMethod();
  JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  TextEditingController roomId = TextEditingController();
  late TextEditingController nameController;
  @override
  void initState() {
    nameController = TextEditingController(text: _authMethod.user.displayName);
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Get.back(); // Do some stuff.
    return true;
  }

  _joinMeeting() async {
    _jitsiMeetMethods.createMeeting(
        roomName: roomId.text,
        isAudioMuted: isAudioMute,
        isVedioMuted: isVedioMute,
        username: nameController.text);
  }

  bool isAudioMute = true;
  bool isVedioMute = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Join meeting"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: roomId,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  filled: true,
                  hintText: "Room ID",
                  fillColor: secondaryBackgroundColor,
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  filled: true,
                  hintText: "Room ID",
                  fillColor: secondaryBackgroundColor,
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: _joinMeeting,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Join",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MeetingTiles(
                text: "Mute mic",
                isMute: isAudioMute,
                onChange: (val) {
                  setState(() {
                    isAudioMute = val;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
            MeetingTiles(
                text: "Video Mute",
                isMute: isVedioMute,
                onChange: (val) {
                  setState(() {
                    isVedioMute = val;
                  });
                })
          ],
        ),
      ),
    );
  }
}
