import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StatusVideo extends StatefulWidget {

  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoSrc;
  final double aspectRatio;

  StatusVideo({
    @required this.videoPlayerController,
    this.looping,
    this.videoSrc,
    this.aspectRatio,
    Key key,
  }): super(key:key);

  @override
  _StatusVideoState createState() => _StatusVideoState();
}

class _StatusVideoState extends State<StatusVideo> {
  ChewieController _chewieController;

  @override
  void initState() {
    print("dur2 "+widget.videoPlayerController.value.position.inMilliseconds.toString());
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize:true,
      looping: widget.looping,
      allowFullScreen: true,
      aspectRatio: 6/9,
      //autoPlay: true,
      errorBuilder: (context, errorMessage){
        return Center(child: Text(errorMessage),);
      }
    );
    
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(      
            padding: EdgeInsets.only(top: 0),
            child: Hero(
              tag: widget.videoSrc,
              child: AspectRatio(
                aspectRatio: 6/10,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}


