import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:status_download/includes/myNavigationDrawer.dart';
import 'package:status_download/pages/about_us.dart';
import 'package:status_download/pages/dashboard.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:status_download/pages/photos.dart';
import 'package:status_download/pages/videos.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PanelController _panelController;
  Future<bool> _readwritePermissionChecker;
  final PermissionHandler _permissionHandler = PermissionHandler();
  final PermissionGroup _permissionGroup=PermissionGroup.storage;
  PermissionStatus _permissionStatus = PermissionStatus.unknown;

  void _listenForPermissionStatus() {
    final Future<PermissionStatus> statusFuture =
    PermissionHandler().checkPermissionStatus(_permissionGroup);
    statusFuture.then((PermissionStatus status) {
      setState(() {
        _permissionStatus = status;
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    requestPermission(PermissionGroup.storage);
  }
  Future<void> requestPermission(PermissionGroup permission) async {
    final List<PermissionGroup> permissions = <PermissionGroup>[permission];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
    await PermissionHandler().requestPermissions(permissions);

    setState(() {
      print(permissionRequestResult);
      _permissionStatus = permissionRequestResult[permission];
      print(_permissionStatus);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status Downloader',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHome(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => DashboardScreen(),
        "/photos": (BuildContext context) => Photos(controller: _panelController,ismodal:true),
        "/videos": (BuildContext context) => VideoListView(),
        "/aboutus": (BuildContext context) => AboutScreen(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  PanelController _panelController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Download WhatsApp Status"),
          //elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: <Widget>[
              Text("Photos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              Text("Videos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Photos(controller: _panelController,),
            VideoListView()
          ],
        ),
        drawer: Drawer(
          child: MyNavigationDrawer(),
        ),
      ),
    );
  }
}
