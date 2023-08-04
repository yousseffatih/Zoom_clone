import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:zoom_clone/variables.dart';

class IntroAuthScreen extends StatefulWidget {
  const IntroAuthScreen({super.key});

  @override
  State<IntroAuthScreen> createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to Zoom Clone , the best video conference app.",
          image: Center(
            child: Image.asset(
              "asset/Images/welcome.png",
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black),
            titleTextStyle: mystyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Join or start  meetings",
          body: "Easy to use iterface , join or start meetings in fast time.",
          image: Center(
            child: Image.asset(
              "asset/Images/conference.png",
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black),
            titleTextStyle: mystyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Security",
          body:
              "Your security is important for us. Our servers are secure and reliable.",
          image: Center(
            child: Image.asset(
              "asset/Images/secure.jpg",
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: mystyle(20, Colors.black),
            titleTextStyle: mystyle(20, Colors.black),
          ),
        ),
      ],
      onDone: () {
        // When done button is press
      },
      showNextButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(Icons.arrow_forward_ios),
      showBackButton: false,
      done: Text(
        "Done",
        style: mystyle(20, Colors.blue),
      ),
    );
  }
}
