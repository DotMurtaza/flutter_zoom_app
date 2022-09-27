import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_app_flutter/Resources/auth_method.dart';

class JitsiMeetMethods {
  AuthMethod _authMethod = AuthMethod();
  void createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVedioMuted,
      String username = ""}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = _authMethod.user.displayName!;
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = _authMethod.user.email
        ..userAvatarURL = _authMethod.user.photoURL // or .png
        ..audioMuted = isAudioMuted
        ..videoMuted = isVedioMuted;

      // ..token = "myToken";
      await _authMethod.saveMeeting(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
