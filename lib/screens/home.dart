import 'package:arpana_portfolio/screens/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state_notifier.dart';
import '../constants.dart';
import '../main.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isdark = appState.isDark;

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 150, left: 40.0),
              child: ListView(
                children: [
                  Text(
                    'Hi,',
                    style: isdark ? homeDarkText : homeText,
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'I\'m Arpana,',
                    style: isdark ? homeDarkText : homeText,
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'Flutter Developer.',
                    style: isdark ? homeDarkText : homeText,
                  ),
                  Text(
                    'CHEERFUL / PASSIONATE / OPTIMISTIC ',
                    style: isdark
                        ? TextStyle(
                            color: Colors.white60,
                            fontSize: 10.0,
                            fontFamily: 'Roboto')
                        : TextStyle(
                            color: myPink,
                            fontSize: 10.0,
                            fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 60.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 150,
                      child: SquareButton(
                          bordercolor: isdark ? myYellow : myPink,
                          textcolor: isdark ? myYellow : myPink,
                          buttontext: 'CONTACT ME',
                          onPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: isdark
                                      ? Color(0xff115173)
                                      : Color(0xffffd9de),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0)),
                                  title: Text("Hey There",
                                      style: isdark ? myDarkText : myText),
                                  content: Text(
                                    "I do nothing ,oops ;)",
                                    style: isdark ? myDarkText : myText,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "Bye",
                                        style: isdark ? myDarkText : myText,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Hero(
              tag: 'arpana',
              child: Container(
                width: 400,
                child: Image.asset('images/git_profile.jpg'),
              ),
            ),
          ),
          SizedBox(
            width: 50,
          )
        ],
      ),
    );
  }
}
