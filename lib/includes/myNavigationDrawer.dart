import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MyNavigationDrawer extends StatelessWidget {
  final _menutextcolor = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  final _iconcolor = new IconThemeData(
    color: Color(0xff757575),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            "Status Downloader",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          accountEmail: Text("Easily Download WhatsApp Statuses"),
          currentAccountPicture: Image.asset('assets/images/avatar.png'),
        ),

        ListTile(
          leading: IconTheme(
            data: IconThemeData(
              color: Color(0xffbfbd21),
            ),
            child: Icon(Icons.photo_library),
          ),
          title: Text("Download Photo Status", style: _menutextcolor),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/photos");
          },
        ),
        ListTile(
          leading: IconTheme(
            data: IconThemeData(
              color: Color(0xff8c0ec7),
            ),
            child: Icon(Icons.video_library),
          ),
          title: Text("Download Video Status", style: _menutextcolor),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/videos");
          },
        ),
        ListTile(
          leading: IconTheme(
            data: IconThemeData(
              color: Color(0xff389c2d),
            ),
            child: Icon(Icons.info),
          ),
          title: Text("About Us", style: _menutextcolor),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed("/aboutus");
          },
        ),
        ListTile(
          leading: IconTheme(
            data: IconThemeData(
              color: Color(0xff1a95ba),
            ),
            child: Icon(Icons.share),
          ),
          title: Text("Share the App", style: _menutextcolor),
          onTap: () {
            // you can modify message if you want.
            Share.share(
                "Hello, Good News\n\n*Download Anyone WhatsApp Status* \n\nDownload Your Contact's Status Photos\nDownload Your Contact's Video Status \n\n*Just Download this Application and You will be able to download other's Whatsapp photo and video Status* \n\n 👇👇👇👇👇 \nDownload Now\nhttp://bit.ly/status-download");
          },
        ),
        ListTile(
          leading: IconTheme(
            data: IconThemeData(
              color: Color(0xff2b2d5c),
            ),
            child: Icon(Icons.rate_review),
          ),
          title: Text("Rate and Review", style: _menutextcolor),
          onTap: () async {
            Navigator.of(context).pop();
            // you can update this link with your app link
            const url =
                'https://play.google.com/store/apps/details?id=com.aicosoft.status_download';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not open App';
            }
          },
        ),
//        ListTile(
//          leading: IconTheme(
//              data: _iconcolor,
//              child: Icon(Icons.security),
//          ),
//          title: Text("Privacy Policy",style: _menutextcolor),
//          onTap: () async {
//            Navigator.of(context).pop();
//            // add privacy policy url
//            const url = 'https://flutterian.com/privacy-policy/';
//            if (await canLaunch(url)) {
//              await launch(url);
//            } else {
//              throw 'Could not open App';
//            }
//          },
//        ),
      ],
    );
  }
}
