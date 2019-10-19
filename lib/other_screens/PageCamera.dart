import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../camera_page/camera_widget.dart';
import 'package:animator/animator.dart';

import 'PageSocial.dart';

class PageCamera extends StatefulWidget {
  final List<CameraDescription> cameras;

  PageCamera(this.cameras, {Key key}) : super(key: key);

  @override
  _PageCameraState createState() => _PageCameraState();
}

class _PageCameraState extends State<PageCamera> with WidgetsBindingObserver {
  static const Duration DURATION = Duration(milliseconds: 350);

  Timer eatMedTimer;

  var ateMed = false;
  var personIdentified = false;
  var medIdentified = false;

  var detectingMeds = false;

  void resetCounter() {
    ateMed = false;
    personIdentified = false;
    medIdentified = false;
    detectingMeds = false;
    showVideo = false;
  }

  void startMedTimer() {
    eatMedTimer = Timer(Duration(seconds: 3), () {
      ateMed = true;
      showVideo = true;
      if (mounted)
        setState(() {

        });
    });
  }

  processRecognitions(recognitions) {
    for (var recognition in recognitions) {
      switch (recognition["detectedClass"]) {
        case "User":
          setState(() => personIdentified = true);
          break;
        case "Pill":
          if (detectingMeds) {
            setState(() => medIdentified = true);
            startMedTimer();
          }
          break;
      }
    }
  }

  @override
  void initState() {
    resetCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: [
        CameraWidget(widget.cameras, (recognitions) => processRecognitions(recognitions)),
        detectingMeds
            ? const SizedBox()
            : !personIdentified
                ? const SizedBox()
                : Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                    child: Animator(
                      duration: DURATION,
                      tween: Tween<double>(begin: 0.0, end: 0.8),
                      builder: (anim) => FadeTransition(
                        opacity: anim,
                        child: RaisedButton(
                          onPressed: () => setState(() {
                            detectingMeds = true;
                            print("detecting meds");
                          }),
                          elevation: 10.0,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            width: 10000.0,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Padding(
                                child: Text(
                                  "Take Meds!",
                                  style: Theme.of(context).textTheme.button,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
        Positioned(
          bottom: 100.0,
          left: 50.0,
          right: 50.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              personIdentified
                  ? new Animator(
                      duration: DURATION,
                      curve: Curves.easeOutCubic,
                      builder: (anim) {
                        return FadeTransition(
                          opacity: anim,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 200.0,
                              height: 50.0,
                              color: Colors.black38,
                              child: Center(
                                child: Text(
                                  "Face verified! Welcome.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              medIdentified
                  ? new Animator(
                      duration: DURATION,
                      curve: Curves.easeOutCubic,
                      builder: (anim) {
                        return FadeTransition(
                          opacity: anim,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 200.0,
                              height: 50.0,
                              color: Colors.black38,
                              child: Center(
                                child: Text(
                                  "Correct meds. Go ahead!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
              const SizedBox(height: 10.0),
              ateMed
                  ? new Animator(
                      duration: DURATION,
                      curve: Curves.easeOutCubic,
                      builder: (anim) {
                        return FadeTransition(
                          opacity: anim,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 200.0,
                              height: 50.0,
                              color: Colors.blue.withAlpha(150),
                              child: Center(
                                child: Text(
                                  "Pillpal matched! Swipe to meet her!",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  /*Widget _cameraPreviewWidget(List value) {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading Camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {

      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return new Stack(alignment: FractionalOffset.center, children: <Widget>[
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.indigo[800],
                Colors.indigo[700],
                Colors.indigo[600],
                Colors.indigo[400],
              ],
            ),
          ),
        ),
        AspectRatio(
            key: _keyCameraPreview,
            aspectRatio: controller.value.aspectRatio,
            child: new CameraPreview(controller)),
        Positioned.fill(
            child: new CustomPaint(
          painter: new DrawObjects(value, _keyCameraPreview),
        )),
        detectingMeds ? const SizedBox() : !personIdentified ? const SizedBox() :
        RaisedButton(
          onPressed: () => detectingMeds = true,
          elevation: 10.0,
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Padding(padding: const EdgeInsets.all(25.0), child: Text("Take Meds!", style: Theme.of(context).textTheme.button,),),

          ),
        ),
        RaisedButton(
          child: Padding(padding: const EdgeInsets.all(25.0), child: Text("Take Meds!", style: Theme.of(context).textTheme.button,),),
          onPressed: () => detectingMeds = true,
          elevation: 10.0,

        ),
        Positioned(
          bottom: 100.0,
          left: 50.0,
          right: 50.0,
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            personIdentified ? new Animator(
              duration: DURATION,
              curve: Curves.easeOutCubic,
              builder: (anim) {
                return FadeTransition(
                  opacity: anim,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 150.0,
                      height: 75.0,
                      color: Colors.black38,
                      child: Text("Face verified! Welcome.", style: Theme.of(context).textTheme.caption,),
                    ),
                  ),
                );
              },
            ) : const SizedBox(),
            const SizedBox(height: 10.0),
            medIdentified ? new Animator(
              duration: DURATION,
              curve: Curves.easeOutCubic,
              builder: (anim) {
                return FadeTransition(
                  opacity: anim,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 150.0,
                      height: 75.0,
                      color: Colors.black38,
                      child: Text("Correct meds. Go ahead!", style: Theme.of(context).textTheme.caption,),
                    ),
                  ),
                );
              },
            ) : const SizedBox(),
            const SizedBox(height: 10.0),
            ateMed ? new Animator(
              duration: DURATION,
              curve: Curves.easeOutCubic,
              builder: (anim) {
                return FadeTransition(
                  opacity: anim,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 150.0,
                      height: 75.0,
                      color: Colors.blue.withAlpha(150),
                      child: Text("Pillpal matched! Swipe to meet her!", style: Theme.of(context).textTheme.caption,),
                    ),
                  ),
                );
              },
            ) : const SizedBox(),
          ],
        ),
        ),

      ],);
    }
  }*/

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //controller?.dispose();
    // detector.dispose();
    super.dispose();
  }

  @override
  void dispose() {
    // controller?.dispose();
    //detector.dispose();
    super.dispose();
  }
}
/*
class DrawObjects extends CustomPainter {
  List values;
  GlobalKey<State<StatefulWidget>> keyCameraPreview;
  DrawObjects(this.values, this.keyCameraPreview);

  @override
  void paint(Canvas canvas, Size size) {
    //print(values);
    if (values==null && values.isNotEmpty && values[0] == null) return;
    final RenderBox renderPreview =
        keyCameraPreview.currentContext.findRenderObject();
    final sizeRed = renderPreview.size;

    var ratioW = sizeRed.width / 416;
    var ratioH = sizeRed.height / 416;
    for (var value in values) {
      var index = value["detectedClass"]; // value["classIndex"];
      // var rgb = colors[index];
      Paint paint = new Paint();
      // paint.color =new Color.fromRGBO(rgb[0].toInt(), rgb[1].toInt(), rgb[2].toInt(), 1);
      paint.color = Colors.black38;
      paint.strokeWidth = 2;
      var rect = value["rect"];
      double x1 = rect["x"] * ratioW, //eft
          x2 = (rect["x"] + rect["w"]) * ratioW, //right
          y1 = rect["y"] * ratioH, //top
          y2 = (rect["y"] + rect["h"]) * ratioH; //bottom
      TextSpan span = new TextSpan(
          style: new TextStyle(
              color: Colors.black,
              background: paint,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          text: " " +/*labels[*/index +" " +(value["confidenceInClass"] * 100).round().toString() +" % "); //confidence
      TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, new Offset(x1 + 1, y1 + 1));
      canvas.drawLine(new Offset(x1, y1), new Offset(x2, y1), paint);
      canvas.drawLine(new Offset(x1, y1), new Offset(x1, y2), paint);
      canvas.drawLine(new Offset(x1, y2), new Offset(x2, y2), paint);
      canvas.drawLine(new Offset(x2, y1), new Offset(x2, y2), paint);
    }

  }

  @override
  bool shouldRepaint(DrawObjects oldDelegate) {
    return true;
  }
}*/
