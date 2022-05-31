import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<Chat> {

  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/Terell.jpg'),
            ),
            SizedBox(width: 10),
            Text(
              "Terell",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Ask them to play with you!!!",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Image.asset(
              'assets/itemillus.png',
              height: 270/pixelRatio,
            ),
          ),
          Spacer(),
          const Divider(
            height: 25.0,
            color: Colors.black,
            thickness: 2.0,
            indent: 0.0,
            endIndent: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0,0.0,0.0,15.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,5.0,0.0),
                  child: Icon(Icons.attach_file, color: Colors.black),
                ),
                Text(
                  "Type your message here",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55.0,0.0,0.0,0.0),
                  child: Icon(Icons.send, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

