import 'dart:io';
import 'package:flutter/material.dart';
import 'package:status_download/pages/video_play.dart';
import 'package:thumbnails/thumbnails.dart';
final Directory _videoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoListView extends StatefulWidget {
  final bool ismodal;

  const VideoListView({Key key, this.ismodal}) : super(key: key);

  @override
  VideoListViewState createState() {
    return new VideoListViewState();
  }
}

class VideoListViewState extends State<VideoListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!Directory("${_videoDir.path}").existsSync()) {
      return Scaffold(
        backgroundColor: Color(0xffE1E6EC),
        appBar: widget.ismodal?AppBar(
          title: Text("Whatsapp Video Status"),
        ):null,
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text("Install WhatsApp\nYour Friend's Status will be available here.", style: TextStyle(
                fontSize: 18.0
            ),),
          ),
        ),
      );
    }
    else{
      return Scaffold(
        backgroundColor: Color(0xffE1E6EC),
        appBar: widget.ismodal?AppBar(
          title: Text("Whatsapp Video Status"),
        ):null,
        body: VideoGrid(directory: _videoDir),
      );
    }
  }
}
class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {

  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType: ThumbFormat.PNG,//this image will store in created folderpath
        quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    List videoList = widget.directory.listSync().map((item) => item.path).where((item) => item.endsWith(".mp4")).toList(growable: false);

    if(videoList!=null){
      if(videoList.length>0){
        return Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: GridView.builder(
            itemCount: videoList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 8.0/8.0),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: ()=> Navigator.push(context, new MaterialPageRoute(
                      builder: (context)=>new PlayStatusVideo(videoList[index])
                  ),),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: FutureBuilder(
                        future: _getImage(videoList[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: videoList[index],
                                      child: Image.file(
                                        File(snapshot.data),
                                        height: 280.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 10),
                                      child:   Container(
                                        decoration: BoxDecoration(
                                            color:Color(0xffb7d8cf) ,
                                            borderRadius: BorderRadius.circular(100.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0XFF6a9172),
                                                  offset: Offset(6, 2),
                                                  blurRadius: 6.0,
                                                  spreadRadius: 3.0
                                              ),
                                              BoxShadow(
                                                  color: Color (0XFF6a9172),
                                                  offset: Offset(-6, -2),
                                                  blurRadius: 6.0,
                                                  spreadRadius: 3.0
                                              )
                                            ]
                                        ),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.only(left: 130),
                                          title: Text("Play Now",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.redAccent,
                                              fontWeight: FontWeight.bold, fontSize: 20),),
                                        ),
                                      ),
                                    ),
                                  ]
                              );
                            }
                            else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }else{
                            return Hero(
                              tag: videoList[index],
                              child: Container(
                                height: 280.0,
                                child: Image.asset("assets/images/video_loader.gif"),
                              ),
                            );
                          }
                        }
                    ),
                    //new cod
                  ),
                ),
              );
            },
          ),
        );
      }else{
        return Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 60.0),
            child: Text("Sorry, No Videos Found.", style: TextStyle(
                fontSize: 18.0
            ),),
          ),
        );
      }
    }else{
      return Center(child: CircularProgressIndicator(),);
    }
  }
}