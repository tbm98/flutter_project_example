import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_example/main.dart';
import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/image.dart' as im;

/// Created by minh.tran on 26/03/2021.

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final path = join(
            // Store the picture in the temp directory.
            // Find the temp directory using the `path_provider` plugin.
            (await getTemporaryDirectory()).path,
            '${DateTime.now()}.jpg',
          );
          await controller.takePicture(path).then((value) async {
            final srcFile = File(path);
            final image = decodeImage(srcFile.readAsBytesSync());
            var orientatedImage = bakeOrientation(image);
            print('image:${image.width},${image.height}');
            print(
                'orientatedImage:${orientatedImage.width},${orientatedImage.height}');

            final file1 = File(join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.jpg',
            ))..writeAsBytesSync(encodeJpg(copyCrop(image, 0, 0, 100, 100)));

            final file2 = File(join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.jpg',
            ))..writeAsBytesSync(encodeJpg(copyCrop(orientatedImage, 0, 0, 100, 100)));

            showDialog(context: context, builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  im.Image.file(file1),
                  im.Image.file(file2),
                ],
              );
            });
          });
        },
      ),
    );
  }
}
