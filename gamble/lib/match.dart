import 'package:flutter/material.dart';

class Match extends StatefulWidget {
  const Match({Key? key}) : super(key: key);

  @override
  State<Match> createState() => _MatchWidgetState();
}

class _MatchWidgetState extends State<Match> {

  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      backgroundColor: Colors.pink[400],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 300/pixelRatio, 0.0, 0.0),
            child: Image.asset(
              'assets/GambleTp.png',
              height: 350/pixelRatio,
            ),
          ),
          Spacer(),
          Text(
            "Match Found!!!",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Image.asset(
              'assets/itemillus.png',
              height: 270/pixelRatio,
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/chat');
            },
            child: Text(
              "Start Chat",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

