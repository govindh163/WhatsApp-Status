import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:status_download/pages/video_controller.dart';
import 'package:video_player/video_player.dart';

class PlayStatusVideo extends StatefulWidget {
  final String videoFile;
  PlayStatusVideo(this.videoFile);

  @override
  _PlayStatusVideoState createState() => _PlayStatusVideoState();
}

class _PlayStatusVideoState extends State<PlayStatusVideo> {
String url="https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  @override
  void initState() {
    super.initState();
    print("here is what you looking for:"+widget.videoFile);
  }

  void dispose() {
    super.dispose();
  }

  void _onLoading(bool t,String str){
    if(t){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return SimpleDialog(
            children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator()),
                ),
              ],
          );
        }
      );
    }else{
      Navigator.pop(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Text("Great, Saved in Gallery", style: TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),),
                        Text(str,style:TextStyle( fontSize:16.0, )),
                        Padding(padding: EdgeInsets.all(10.0),),
                        Text("FileManager > Downloaded Status",style:TextStyle( fontSize:16.0, color: Colors.teal )),
                        Padding(padding: EdgeInsets.all(10.0),),
                        MaterialButton(
                          child: Text("Close"),
                          color:Colors.teal,
                          textColor: Colors.white,
                          onPressed:  ()=> Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1E6EC),
      appBar:AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.indigo,
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: ()=> Navigator.of(context).pop(),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: StatusVideo(
                videoPlayerController: VideoPlayerController.file(File(widget.videoFile)),
                looping: true,
                videoSrc: widget.videoFile,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
              child:  FlatButton.icon(
                color:Colors.indigo,
                textColor: Colors.white,
                icon: Icon(Icons.file_download),
                padding: EdgeInsets.all(10.0),
                label: Text('Download', style: TextStyle(
                    fontSize:16.0
                ),), //`Text` to display
                onPressed: () async{
                  _onLoading(true,"");

                  File originalVideoFile = File(widget.videoFile);
                  Directory directory = await getExternalStorageDirectory();
                  if(!Directory("${directory.path}/Downloaded Status/Videos").existsSync()){
                    Directory("${directory.path}/Downloaded Status/Videos").createSync(recursive: true);
                  }
                  String path = directory.path;
                  String curDate = DateTime.now().toString();
                  String newFileName = "$path/Downloaded Status/Videos/VIDEO-$curDate.mp4";
                  print(newFileName);
                  await originalVideoFile.copy(newFileName);

                  _onLoading(false,"You can find all downloaded videos at");
                },
              ),
            ),
//            Container(
//              child: StatusVideoNetwork(
//                videoPlayerController: VideoPlayerController.network(url ),
//                looping: true,
////                videoSrc: widget.videoFile,
//              ),
//            ),
          ],
        ),
      ),
    ); 
  }
}
class StatusVideoNetwork extends StatefulWidget {

  final VideoPlayerController videoPlayerController;
  final bool looping;
  final String videoSrc;
  final double aspectRatio;

  StatusVideoNetwork({
    @required this.videoPlayerController,
    this.looping,
    this.videoSrc,
    this.aspectRatio,
    Key key,
  }): super(key:key);

  @override
  _StatusVideoNetworkState createState() => _StatusVideoNetworkState();
}

class _StatusVideoNetworkState extends State<StatusVideoNetwork> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    //widget.videoPlayerController.addListener(checkVideo);

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
//  void checkVideo() {
//    // Implement your calls inside these conditions' bodies :
//    if (widget.videoPlayerController.value.position ==
//        Duration(seconds: 0, minutes: 0, hours: 0)) {
//      Scaffold.of(context).showSnackBar(SnackBar(
//        content: Text("Video Started"),
//        duration: Duration(seconds: 3),
//      ));
//      print('video Started');
//
//    }
//    if (widget.videoPlayerController.value.position ==
//        Duration(seconds: 9, minutes: 0, hours: 0)) {
//      print('video Started at 23');
//    }
//    if (widget.videoPlayerController.value.position ==
//        widget.videoPlayerController.value.duration) {
//      print('video Ended');
//    }
//  }
  @override
  Widget build(BuildContext context) {
   // print("dur"+widget.videoPlayerController.value.position.toString());
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 0),
            child: AspectRatio(
              aspectRatio: 6/10,
              child: Chewie(
                controller: _chewieController,
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
