import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset("assets/videos/road.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Colors.redAccent.withAlpha(0),
    );
  }

  _getLoginButtons() {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: FlatButton(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text('Sign Up with Email'),
          onPressed: () async {},
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        width: double.infinity,
        child: FlatButton(
          color: Colors.redAccent,
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text(
            'Log back in',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {},
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 16, top: 20, left: 20, right: 20),
        width: double.infinity,
        child: FlatButton(
          child: const Text(
            'Continue without login',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.pushNamed(context, '/earth'),
        ),
      ),
    ];
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Text(
          "TravelMarker",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: Text(
            "Add and view markers on the places for new and passed trips",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Spacer(),
        ..._getLoginButtons()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}
