import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LHalloween',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halloween'),
      ),
      body: Center(
        child: Column( 
          children: <Widget>[ 
            SizedBox(
              width:500,
              height:500,
              child: PhotoView(
                imageProvider: NetworkImage('https://th.bing.com/th/id/R.63486e8678909ac3005d1be748fd7449?rik=OlV1FJKB4EOcWw&riu=http%3a%2f%2fimages.clipartpanda.com%2fcute-bat-clipart-bat-20clip-20art-bat-1979px.png&ehk=GEzb7%2bK1oYvqPhGykDqpHWSumSNEAIGbKDrVhmtzz4Y%3d&risl=&pid=ImgRaw&r=0'),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered *2,
                backgroundDecoration: BoxDecoration(color: Colors.white),)
              
            )
          ],
        ),
      ),
    );}}