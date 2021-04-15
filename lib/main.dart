import 'package:animations/animations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_example/banner.dart';
import 'package:flutter_project_example/take_photo.dart';

import 'open_transition.dart';

List<CameraDescription> cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
      backgroundColor: Colors.white,
      body: Center(
        child: HiText(
          text: '$text/$hiCount',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            hiCount++;
          });

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TakePhoto();
          }));
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
      child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BannerWidget(
        aspectRatio: 3,
      ),
              SizedBox(height: 20,),
              OpenContainerWrapper(
                transitionType: ContainerTransitionType.fade,
                closedBuilder: (_, openContainer) {
                  return ExampleCard(openContainer: openContainer);
                },
              ),
            ],
          )),
    );
  }
}
