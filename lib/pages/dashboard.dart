import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:status_download/pages/photos.dart';
import 'package:status_download/pages/videos.dart';
//import 'package:firebase_admob/firebase_admob.dart';

//const String testDevice = '';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PanelController _panelController;
  final double _radius = 25.0;
//  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
//    //testDevices: <String>[],
//    keywords: <String>['live chat','dating','bigo'],
//  );

//  BannerAd _bannerAd;
//
//  BannerAd createBannerAd(){
//    return new BannerAd(
//      adUnitId: BannerAd.testAdUnitId,
//      size: AdSize.banner,
//      targetingInfo: targetInfo,
//      listener: (MobileAdEvent event){
//      }
//    );
//  }

//  InterstitialAd _interstitialAd;
//
//  InterstitialAd createInterstitialAd(){
//    return new InterstitialAd(
//        adUnitId: InterstitialAd.testAdUnitId,
//        targetingInfo: targetInfo,
//        listener: (MobileAdEvent event){
//        }
//    );
//  }
  @override
  void initState() {
    _panelController = PanelController();

    super.initState();
  }

  @override
  void dispose() {
    _panelController.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE1E6EC),
      body: SlidingUpPanel(
        slideDirection: SlideDirection.UP,

        panel: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_radius),
            topRight: Radius.circular(_radius),
          ),
          child: Photos(controller: _panelController),
        ),
        controller: _panelController,
        minHeight: 90,
        maxHeight: MediaQuery.of(context).size.height/2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
        collapsed: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
            ),
            gradient: LinearGradient(
                colors: [
                  Colors.purple[800],
                  Colors.purple[700],
                  Colors.purple[600],
                  Colors.purple[500],
                  Colors.purple[400],
                  Colors.purple[800],
                ]
            ),
          ),
          child: BottomPanel(controller: _panelController),
        ),
        body: Container(
          color:Color(0xffe8e8e8),
          child: ListView(
              children: <Widget>[
                //Welcome and Balance Info
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.purple[800],
                            Colors.purple[700],
                            Colors.purple[600],
                            Colors.purple[500],
                            Colors.purple[400],
                            Colors.purple[800],
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
//                  createInterstitialAd()
//                    ..load()
//                    ..show();
                        Navigator.of(context).push( MaterialPageRoute(
                          builder: (BuildContext context) =>Photos(controller: _panelController,),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Photo Status",style: TextStyle(
                            fontSize:24.0,
                            color:Colors.white,
                          )),
                          Text("Click here to view all photo status.",style: TextStyle(
                            fontSize:17.0,
                            color:Colors.white70,
                          )),

                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.teal[800],
                            Colors.teal[700],
                            Colors.teal[600],
                            Colors.teal[500],
                            Colors.teal[400],
                            Colors.teal[800],
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: (){
//                  createInterstitialAd()
//                    ..load()
//                    ..show();
                        Navigator.of(context).push( MaterialPageRoute(
                          builder: (BuildContext context) =>VideoListView(),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Videos Status",style: TextStyle(
                            fontSize:24.0,
                            color:Colors.white,
                          )),
                          Text("Click here to view all videos status.",style: TextStyle(
                            fontSize:17.0,
                            color:Colors.white70,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.indigo[800],
                            Colors.indigo[700],
                            Colors.indigo[600],
                            Colors.indigo[500],
                            Colors.indigo[600],
                            Colors.indigo[800],
                          ]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 3.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("File Manager > Downloaded Status ",style: TextStyle(
                          fontSize:20.0,
                          color:Colors.white,
                        )),
                        Padding(padding: EdgeInsets.all(5.0),),
                        Text("All photos and videos will be saved in Downloaded Status Folder.",style: TextStyle(
                          fontSize:17.0,
                          color:Colors.white70,
                        )),
                      ],
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class BottomPanel extends StatelessWidget {
  final PanelController _controller;

  BottomPanel({@required PanelController controller})
      : _controller = controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.open(),
      child: ShowIcon(

      ),
    );
  }
}
class ShowIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double _radius = 32;
    return Container(
      width: _radius,
      height: _radius,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(
          _radius,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
          size: 22.0,
        ),
      ),
    );
  }
}