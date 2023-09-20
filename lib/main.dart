import 'package:arpana_portfolio/constants.dart';
import 'package:arpana_portfolio/screens/about.dart';
import 'package:arpana_portfolio/screens/contact.dart';
import 'package:arpana_portfolio/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:provider/provider.dart';
import 'package:google_maps/google_maps.dart' as GoogleMaps;

import 'app_state_notifier.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyAppState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arpana\'s Portfolio',
      theme: context.watch<MyAppState>().isDark
          ? ThemeClass.darkTheme
          : ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
              navigationRailTheme: NavigationRailThemeData(
                  selectedLabelTextStyle: TextStyle(
                color: myPink,
                fontFamily: 'Cursive',
              )),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: inputfieldPink,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: myPink, width: 1.0),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myPink, width: 1.0),
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    Widget? page;
    switch (selectedIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = About();
        break;
      case 2:
        page = Contact();
        break;
      case 3:
        page = null;
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: NavigationRail(
                minExtendedWidth: 25.0,
                extended: constraints.maxWidth >= 800,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    label: Text('About'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.email),
                    label: Text('Contact'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.brightness_4_rounded),
                    label: Text('Theme'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  if (value == 3) {
                    // toggle the state
                    appState.toggleTheme();
                  } else {
                    setState(() {
                      selectedIndex = value;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ThemeClass {
  static final ThemeData darkTheme = ThemeData(
    //hoverColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.pink,
      onPrimary: Colors.teal,
      primaryContainer: Color(0xff022c43),
      secondary: Color(0xfffed600),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Color(0xfffed600), fontFamily: 'Cursive'),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.black, // Background color of the navigation rail
      selectedIconTheme:
          IconThemeData(color: Color(0xfffed600)), // Color of the selected icon
      selectedLabelTextStyle: TextStyle(
          color: Color(0xfffed600),
          fontFamily: 'Cursive'), // Color of the selected label
      unselectedIconTheme:
          IconThemeData(color: Colors.white24), // Color of unselected icons
      unselectedLabelTextStyle:
          TextStyle(color: Colors.white24), // Color of unselected labels
      useIndicator: true,
      indicatorColor: Colors.transparent,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputfieldColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: myYellow, width: 1.0),
        borderRadius: BorderRadius.circular(0.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0.0),
        borderRadius: BorderRadius.circular(0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(0.0),
      ),
    ),
  );
}

class SquareButton extends StatelessWidget {
  SquareButton(
      {required this.bordercolor,
      required this.textcolor,
      required this.buttontext,
      required this.onPress});
  final Color bordercolor;
  final Color textcolor;
  final String buttontext;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        buttontext,
        style: TextStyle(
          letterSpacing: 2.0,
          color: textcolor,
        ),
      ),
      style: TextButton.styleFrom(
        side: BorderSide(color: bordercolor, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              0.0), // Set the border radius to 0 for sharp corners
        ),
      ),
    );
  }
}
