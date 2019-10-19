import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

typedef void DetectionCallback(List<dynamic> recognitions);

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  final DetectionCallback callback;

  CameraWidget(this.cameras, this.callback);

  @override
  _CameraWidgetState createState() => new _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  var modelLoaded = false;

  @override
  void initState() {
    Timer t = Timer(
      Duration(milliseconds: 200),
      () => onSelect(yolo),
    );
    super.initState();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(model: "assets/mobilenet_v1_1.0_224.tflite", labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(model: "assets/ssd_mobilenet.tflite", labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
    setState(() => modelLoaded = true);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  List asPillList = [
    "stop sign",
    "frisbee",
    "sports ball",
    "kite",
    "bottle",
    "mouse",
    "donut",
    "cake",
  ];

  setRecognitions(recognitions, imageHeight, imageWidth) {
    for (var r in recognitions){
      if (r["detectedClass"] == "person"){
        r["detectedClass"] = "User";
      } else if (asPillList.contains(r["detectedClass"].toString())){
        r["detectedClass"] = "Pill";
      }
    }

    widget.callback(recognitions);

    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _model == "" && !modelLoaded
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  /*RaisedButton(
                    child: const Text(ssd),
                    onPressed: () => onSelect(ssd),
                  ),
                  RaisedButton(
                    child: const Text(yolo),
                    onPressed: () => onSelect(yolo),
                  ),
                  RaisedButton(
                    child: const Text(mobilenet),
                    onPressed: () => onSelect(mobilenet),
                  ),
                  RaisedButton(
                    child: const Text(posenet),
                    onPressed: () => onSelect(posenet),
                  ),*/
                ],
              ),
            )
          : Stack(
              children: [
                Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                Opacity(
                  opacity: 0.5,
                  child: BndBox(
                    _recognitions == null ? [] : _recognitions,
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model,
                  ),
                ),
              ],
            ),
    );
  }
}
