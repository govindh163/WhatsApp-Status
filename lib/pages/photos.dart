import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:status_download/pages/view_photo.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

final Directory _photoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class Photos extends StatefulWidget {
  final PanelController _controller;
 final bool ismodal;

  Photos({@required PanelController controller,this.ismodal})
      : _controller = controller;
  @override
  PhotosState createState() {
    return new PhotosState(controller:_controller );
  }
}

class PhotosState extends State<Photos> {
  final PanelController _controller;

  PhotosState({@required PanelController controller})
      : _controller = controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!Directory("${_photoDir.path}").existsSync()) {
      return Scaffold(
        backgroundColor: Color(0xffE1E6EC),
        appBar: AppBar(
          title: Text("Whatsapp Photo Status"),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text("Install WhatsApp\nYour Friend's Status will be available here.", style: TextStyle(
              fontSize: 18.0
            ),),
          ),
        ),
      );
    }else {
      var imageList = _photoDir.listSync().map((item) => item.path).where((
          item) => item.endsWith(".jpg")).toList(growable: false);

      if (imageList.length > 0) {
        return Scaffold(
          backgroundColor: Color(0xffE1E6EC),
          appBar: widget.ismodal?AppBar(
            title: Text("Whatsapp Photo Status"),
//           actions: <Widget>[
//             GestureDetector(
//               onTap: () => _controller.close(),
//               child: HideIcon(
//                 color: Colors.white,
//               ),
//             ),
//           ],
          ):null,
          body: Container(
            padding: EdgeInsets.only(bottom: 60.0),
            child: StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () =>
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) => new ViewPhotos(imgPath)
                        ),),
                    child: Hero(
                      tag: imgPath,
                      child: Image.file(
                        File(imgPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 3),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
          ),
         );
      } else {
        return Scaffold(
          backgroundColor: Color(0xffE1E6EC),
          appBar: widget.ismodal?AppBar(
            title: Text("Whatsapp Photo Status"),
          ):SizedBox(),
          body: GestureDetector(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Text("Sorry, No Images Found.", style: TextStyle(
                    fontSize: 18.0
                ),),
              ),
            ),
          ),
        );
      }
    }
  }
}
class HideIcon extends StatelessWidget {
  final Color _color;

  HideIcon({@required Color color}) : _color = color;

  @override
  Widget build(BuildContext context) {
    final double _radius = 32;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: _color,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_down,
          color: _color,
          size: 22.0,
        ),
      ),
    );
  }
}

