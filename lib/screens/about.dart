import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state_notifier.dart';
import '../constants.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool heartStatus = false;
// animation controller
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this, lowerBound: 0.5);
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
        reverseCurve: accelerateEasing);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
        setState(() {
          heartStatus = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
        setState(() {
          heartStatus = false;
        });
      }
    });

    controller.addListener(() {
      setState(() {
        // print(animation.value);
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the animation controller to release resources
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isdark = appState.isDark;
    return Center(
        child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(
                  height: 100.0,
                ),
                Text(
                  'About Me',
                  style: isdark
                      ? myDarkText.copyWith(
                          fontSize: 50.0, fontFamily: 'Cursive')
                      : myText.copyWith(fontSize: 50.0, fontFamily: 'Cursive'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'I\'m a developer and I am passionate about developing cute UI\'s. Recently started developing user interface using Google\'s frontend toolkit Flutter.',
                  softWrap: true,
                  style: isdark ? myDarkText : myText,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'I\'m very cheerful personality and always see my mistakes as an opportunity to learn and grow, and I feel every failure is a step up to success.',
                  softWrap: true,
                  style: isdark ? myDarkText : myText,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'And yes every success comes with a price so to motivate people I will say DO THE HARDWOEK ESPECIALLY WHEN YOU DON\'T FEEL LIKE IT.',
                  softWrap: true,
                  maxLines: 3,
                  style: isdark ? myDarkText : myText,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    color: isdark ? Color(0xff022c43) : Color(0xffffd9de),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.favorite,
                      size: animation.value * 100,
                      color: isdark ? myYellow : myPink,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isdark
                        ? myYellow
                        : myPink, // Choose the color of your border
                    width:
                        animation.value * 10, // Adjust the width of your border
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/git_profile.jpg'),
                  radius: 150,
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
