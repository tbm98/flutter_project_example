import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_example/banner.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'hi';
  int hiCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HiText(text: '$text/$hiCount',),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            hiCount ++;
          });
        },
      ),
    );
  }
}

class HiText extends StatefulWidget {
  HiText({this.text});

  String text;

  @override
  _HiTextState createState() => _HiTextState();
}

class _HiTextState extends State<HiText> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: BannerWidget(aspectRatio: 3,)),
    );
  }
}
