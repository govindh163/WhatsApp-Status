import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {


  @override
  void initState() {
    super.initState();
  }
  
  _launchURL() async {
    const url = 'https://smartiapps.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open App';
    }
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 238, 238),
      appBar: AppBar(
        title: Text("About us"),
      ),
      body: Container(
        color:Color(0xffe8e8e8),
        child: ListView(
          children: <Widget>[
            //Welcome and Balance Info
            Container(
              padding: EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                    "We Are the best Website and Mobile App Development Company",
                    style: TextStyle(
                      fontSize:18.0,
                      color:Colors.indigo,
                    )),
                    SizedBox(height: 40,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        width: 350,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 238, 238, 238),
                            boxShadow: [
                              BoxShadow(offset: Offset(10, 10),color: Color.fromARGB(80, 0, 0, 0),blurRadius: 10),
                              BoxShadow(offset: Offset(-10, -10),color: Color.fromARGB(150, 255, 255, 255),blurRadius: 10)
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              onPressed: (){
                                _launchURL();
                              },
                              padding: EdgeInsets.all(20.0),
                              child: Text("Tap to Read More",style: TextStyle(
                                fontSize:24.0,
                                color:Colors.white,
                              )),
                              color: Colors.white30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
    
    
  }
}