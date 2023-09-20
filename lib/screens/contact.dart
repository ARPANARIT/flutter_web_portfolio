import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../app_state_notifier.dart';
import '../constants.dart';
import '../main.dart';
import 'dart:html';

import 'package:google_maps/google_maps.dart';
import 'dart:ui_web' as ui;

class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  bool _enableBtn = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  Future sendEmail(
      {required String name,
      required String subject,
      required String email,
      required String message}) async {
    final serviceId = 'service_f4l868q';
    final templateId = 'template_o6xjqb8';
    final userId = '3edSOyH2zBwp5yv2N';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_subject': subject,
            'user_message': message
          }
        }));
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
              child: Form(
                key: _formKey,
                onChanged: (() {
                  setState(() {
                    _enableBtn = _formKey.currentState!.validate();
                  });
                }),
                child: ListView(
                  children: [
                    Text(
                      'Contact',
                      style: isdark
                          ? myDarkText.copyWith(
                              fontSize: 50.0, fontFamily: 'Cursive')
                          : myText.copyWith(
                              fontSize: 50.0, fontFamily: 'Cursive'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFields(
                            controller: nameController,
                            maxLines: 1,
                            hinttext: 'Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name is Required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextFields(
                              controller: emailController,
                              hinttext: "Email",
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              })),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFields(
                        controller: subjectController,
                        hinttext: "Subject",
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        })),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextFields(
                        controller: messageController,
                        hinttext: "Message",
                        validator: ((value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _enableBtn = true;
                            });
                            return 'Message is required';
                          }
                          return null;
                        }),
                        maxLines: 8,
                        type: TextInputType.multiline),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SquareButton(
                        bordercolor: isdark ? myYellow : myPink,
                        textcolor: isdark ? myYellow : myPink,
                        buttontext: 'SEND',
                        onPress: _enableBtn
                            ? (() async {
                                await sendEmail(
                                    name: nameController.text,
                                    subject: subjectController.text,
                                    email: emailController.text,
                                    message: messageController.text);

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: isdark
                                          ? Color(0xff115173)
                                          : Color(0xffffd9de),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.0)),
                                      title: Text("Have a Great Day ;D",
                                          style: isdark ? myDarkText : myText),
                                      content: Text(
                                        "Email Sent successfully",
                                        style: isdark ? myDarkText : myText,
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                            "OK",
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
                                nameController.clear();
                                subjectController.clear();
                                emailController.clear();
                                messageController.clear();
                              })
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: getMap(),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? type;
  TextFields(
      {required this.controller,
      required this.hinttext,
      required this.validator,
      this.maxLines,
      this.type});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isdark = appState.isDark;
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      style: TextStyle(color: isdark ? Colors.white : myPink),
      cursorColor: isdark ? myYellow : myPink,
      decoration: inputDecor.copyWith(
        hintText: hinttext,
        hintStyle: TextStyle(color: isdark ? Colors.white60 : myPink),
      ),
    );
  }
}

Widget getMap() {
  String htmlId = "7";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final myLatlng = LatLng(19.30655786082651, 72.86313613052295);

    final mapOptions = MapOptions()
      ..zoom = 10
      ..center = LatLng(19.30655786082651, 72.86313613052295);

    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none';

    final map = GMap(elem, mapOptions);

    Marker(MarkerOptions()
      ..position = myLatlng
      ..map = map
      ..title = 'Arpana Lives here');

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}
