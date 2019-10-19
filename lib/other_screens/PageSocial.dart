import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';
import '../main.dart';

bool showVideo = false;

class PageSocial extends StatefulWidget {
  final List<CameraDescription> cameras;

  PageSocial(this.cameras, {Key key}) : super(key: key);

  @override
  _PageSocialState createState() => _PageSocialState();
}

class _PageSocialState extends State<PageSocial> {
  VideoPlayerController _controller;
  CameraController cameraController;

  bool cameraInitialised = false;

  @override
  void initState() {

    cameraController = new CameraController(
      widget.cameras[cameraSide],
      ResolutionPreset.medium,
    );

    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var body;

    var screen = MediaQuery.of(context).size;

    if (showVideo) {
      body = Stack(
        children: [
          Center(
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            right: 20.0,
            bottom: 20.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: screen.width / 3,
                height: screen.height / 3,
                color: Colors.orange.withAlpha(50),
                child: CameraPreview(cameraController),
              ),
            ),
          ),
        ],
      );
    } else {
      body = SingleChildScrollView(
        child: Image.asset('assets/You Page.png', fit: BoxFit.fitWidth,),
        physics: BouncingScrollPhysics(),
      );
    }

    return Stack(
        fit: StackFit.expand,
        children:[
          Container(color: Colors.white, height: 10000.0, width: 10000.0),
          body,
        ]
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
