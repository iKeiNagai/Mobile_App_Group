import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
  }

  void _playaudio() {
    _audioPlayer.setAsset('assets/audio/short-high-pitched-laugh-242960.mp3');
    _audioPlayer.play();
  }

  Future<void> _playBackgroundMusic() async {
    await _backgroundPlayer.setAsset('assets/audio/thunder.mp3');
    _backgroundPlayer.setLoopMode(LoopMode.one);
    _backgroundPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halloween'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.orange,
          ),
          Center(
            child: GestureDetector(
              onTap: _playaudio,
              child: SizedBox(
                width: 100,
                height: 100,
                child: PhotoView(
                  imageProvider: NetworkImage(
                      'https://th.bing.com/th/id/R.63486e8678909ac3005d1be748fd7449?rik=OlV1FJKB4EOcWw&riu=http%3a%2f%2fimages.clipartpanda.com%2fcute-bat-clipart-bat-20clip-20art-bat-1979px.png&ehk=GEzb7%2bK1oYvqPhGykDqpHWSumSNEAIGbKDrVhmtzz4Y%3d&risl=&pid=ImgRaw&r=0'),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: BoxDecoration(color: Colors.orange),
                ),
              ),
            ),
          ),
          Positioned(
              top: 100,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: Image.network(
                    'https://th.bing.com/th/id/OIP.DgZoDDyZOj5zBZMHAdUgSQHaGl?rs=1&pid=ImgDetMain'),
              ),),
          Positioned(
            bottom: 100,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.orange,
              child: Image.network('https://th.bing.com/th/id/R.75416d6811fcc1c9de60cb1981800bab?rik=mFU1EpKr1bdrGQ&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fscary-cat-silhouette%2fscary-cat-silhouette-2.png&ehk=3FvTA1pX39s6tEMObBDLGXxxV2VHTtHIGMvtkqBXGso%3d&risl=&pid=ImgRaw&r=0'),
            ))
        ],
      ),
    );
  }
}
