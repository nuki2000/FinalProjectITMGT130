import 'dart:math';
import 'package:final_project_dating_app/card_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cardd extends StatefulWidget {
  final String groupImage;
  final bool isFront;

  const Cardd({
    Key? key,
    required this.groupImage,
    required this.isFront,
  }) : super(key:key);

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  final user = FirebaseAuth.instance.currentUser!;

  String _username = '';
  String _age = '19';
  String _gender = 'M';
  String _gamePref = '';
  String _gameTime = '';
  String _gamerType = '';

  String get username => _username;
  String get age => _age;
  String get gender => _gender;
  String get gamePref => _gamePref;
  String get gameTime => _gameTime;
  String get gamerType => _gamerType;


  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final user = FirebaseAuth.instance.currentUser!;

    return SizedBox.expand(
      child: widget.isFront ? buildFrontCard() : buildCard(),
    );
  }

  Widget buildFrontCard() => GestureDetector(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final provider = Provider.of<CardProvider>(context, listen: true);
        final position = provider.position;
        final milliseconds = provider.isDragging ? 0 :400;

        final center = constraints.smallest.center(Offset.zero);
        final angle = provider.angle * pi / 180;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
          transform: rotatedMatrix..translate(position.dx, position.dy),
          child: Stack(
            children: [
              buildCard(),
              buildStamps(),
            ],
          ),
        );
      },
    ),
    onPanStart: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.startPosition(details);
    },
    onPanUpdate: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.updatePosition(details);
    },
    onPanEnd: (details){
      final provider = Provider.of<CardProvider>(context, listen: false);

      provider.endPosition();
    },
  );

  Widget buildCard() => ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.groupImage),
            fit: BoxFit.cover,
            alignment: Alignment(-0.3, 0),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4, 1],
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Spacer(),
                buildName(),
              ],
            ),
          ),
        ),
      ),
    );

  Widget buildName() {
    switch(widget.groupImage) {
      case 'assets/Carlos.jpg':
        _username = 'Carlos';
        _age = '22';
        _gender = 'M';
        _gamePref = 'MOBA/FPS';
        _gameTime = '9pm - 12mn';
        _gamerType = 'Pro';
        break;
      case 'assets/Brandon.jpg':
        _username = 'Brandon';
        _age = '21';
        _gender = 'M';
        _gamePref = 'Sandbox/Open World';
        _gameTime = '8pm - 12mn';
        _gamerType = 'Casual';
        break;
      case 'assets/Niccolo.jpg':
        _username = 'Niccolo';
        _age = '22';
        _gender = 'M';
        _gamePref = 'FPS/MOBA';
        _gameTime = '12mn - 5am';
        _gamerType = 'Casual/Competitive';
        break;
      case 'assets/Terell.jpg':
        _username = 'Terell';
        _age = '22';
        _gender = 'M';
        _gamePref = 'MOBA/FPS';
        _gameTime = '8pm - 2am';
        _gamerType = 'Casual';
        break;
      case 'assets/Gabriel.jpg':
        _username = 'Gabriel';
        _age = '22';
        _gender = 'M';
        _gamePref = 'FPS';
        _gameTime = '12mn - 5am';
        _gamerType = 'Competitive/Casual';
        break;
      default:
        _username = ' ';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              username,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              age,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              gender,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          gamerType,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          gamePref,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          gameTime,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();

    switch(status) {
      case CardStatus.like:
        final child = buildStamp(
            angle: -0.5,
            color: Colors.green,
            text: 'LIKE',
            opacity: opacity,
        );

        return Positioned(top: 64, left: 30, child: child);
        break;
      case CardStatus.dislike:
        final child = buildStamp(
            angle: 0.5,
            color: Colors.red,
            text: 'NOPE',
            opacity: opacity,
        );

        return Positioned(top: 64, right: 20, child: child);
        break;
      case CardStatus.superlike:
        final child = buildStamp(
            angle: -0.5,
            color: Colors.blue,
            text: 'SUPER\nLIKE',
            opacity: opacity,
        );

        return Positioned(bottom: 128, right: 0, left: 0, child: child);
        break;
      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required Color color,
    required String text,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 4),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}