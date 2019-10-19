import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'other_screens/entry.dart';

List<CameraDescription> cameras;
int cameraSide = 0;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}
