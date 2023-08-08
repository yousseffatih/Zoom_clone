import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zoom_clone/variables.dart';

class JoingMeeting extends StatefulWidget {
  const JoingMeeting({super.key});

  @override
  State<JoingMeeting> createState() => _JoingMeetingState();
}

class _JoingMeetingState extends State<JoingMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isVideoMuted = true;
  bool isAudioMuted = true;
  String username = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  getuserdata() async {
    // DocumentSnapshot userdoc =
    //     await usercollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    var userdoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = userdoc.data()!['username'];
    });
  }

  joingMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureflag = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      if (Platform.isAndroid) {
        featureflag[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureflag[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions(
        room: roomController.text,
      )
        ..userDisplayName =
            nameController.text == '' ? username : nameController.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureflag); //dc783b

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Erro : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text(
                "Room code",
                style: mystyle(20),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                controller: roomController,
                autoDisposeControllers: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                ),
                animationDuration: const Duration(milliseconds: 300),
                length: 6,
                onChanged: (value) {},
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                style: mystyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name (leave if you want your username)",
                  labelStyle: mystyle(15),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value!;
                  });
                },
                title: Text(
                  "Video Muted",
                  style: mystyle(18),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isVideoMuted = value!;
                  });
                },
                title: Text(
                  "Audio Muted",
                  style: mystyle(18),
                ),
              ),
              Text(
                "Of course, you can customise your settings in the meeting.",
                style: mystyle(15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joingMeeting(),
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                    child: Text(
                      "Join Meeting",
                      style: mystyle(
                        20,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
