import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project_dating_app/card.dart';
import 'package:final_project_dating_app/card_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.black,
          ],
          stops: [0.4, 1],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                buildLogo(),
                const SizedBox(height: 16),
                Expanded(child: buildCards()),
                const SizedBox(height: 16),
                buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLogo() => Padding(
    padding: EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Image.asset(
        'assets/GambleTp.png',
        height: 36,
      ),
    ),
  );

  Widget buildButtons() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final isLike = status == CardStatus.like;
    final isDislike = status == CardStatus.dislike;
    final isSuperlike = status == CardStatus.superlike;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                final provider = Provider.of<CardProvider>(
                    context, listen: false);

                provider.dislike();
              },
              child: Icon(Icons.clear, color: Colors.red, size: 40),
              style: ButtonStyle(
                foregroundColor: getColor(Colors.red, Colors.white, isDislike),
                backgroundColor: getColor(Colors.white, Colors.red, isDislike),
                side: getBorder(Colors.red, Colors.black54, isDislike),
                shape: getShape(),
                elevation: getElevation(),
                minimumSize: getSize(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final provider = Provider.of<CardProvider>(
                    context, listen: false);

                provider.superlike();
              },
              child: Icon(Icons.star, color: Colors.blue, size: 40),
              style: ButtonStyle(
                foregroundColor: getColor(Colors.blue, Colors.white, isSuperlike),
                backgroundColor: getColor(Colors.white, Colors.blue, isSuperlike),
                side: getBorder(Colors.blue, Colors.black54, isSuperlike),
                shape: getShape(),
                elevation: getElevation(),
                minimumSize: getSize(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final provider = Provider.of<CardProvider>(
                    context, listen: false);

                provider.like();
                Navigator.pushReplacementNamed(context, '/match');
              },
              child: Icon(Icons.favorite, color: Colors.teal, size: 40),
              style: ButtonStyle(
                foregroundColor: getColor(Colors.teal, Colors.white, isLike),
                backgroundColor: getColor(Colors.white, Colors.teal, isLike),
                side: getBorder(Colors.teal, Colors.black54, isLike),
                shape: getShape(),
                elevation: getElevation(),
                minimumSize: getSize(),
              ),
            ),
          ],
        );
  }

    MaterialStateProperty<Color> getColor(
        Color color, Color colorPressed, bool force) {
      final getColor = (Set<MaterialState> states) {
        if (force || states.contains(MaterialState.pressed)){
          return colorPressed;
        } else {
          return color;
        }
      };

      return MaterialStateProperty.resolveWith(getColor);
    }

    MaterialStateProperty<OutlinedBorder> getShape() {
      final getShape = (Set<MaterialState> states) {
        return CircleBorder();
      };

      return MaterialStateProperty.resolveWith(getShape);
    }

    MaterialStateProperty<double> getElevation() {
      final getElevation = (Set<MaterialState> states) {
        return 8.0;
      };

      return MaterialStateProperty.resolveWith(getElevation);
    }

    MaterialStateProperty<Size> getSize() {
      final getSize = (Set<MaterialState> states) {
        return Size.square(70);
      };

      return MaterialStateProperty.resolveWith(getSize);
    }

    MaterialStateProperty<BorderSide> getBorder(
        Color color, Color colorPressed, bool force) {
      final getBorder = (Set<MaterialState> states) {
        if (force || states.contains(MaterialState.pressed)){
          return BorderSide(color: colorPressed, width: 2);
        } else {
          return BorderSide(color: color, width: 2);
        }
      };

      return MaterialStateProperty.resolveWith(getBorder);
    }

    Widget buildCards() {
      final provider = Provider.of<CardProvider>(context);
      final groupImages = provider.groupImages;

      return groupImages.isEmpty
          ? Center(

          )
          : Stack(
        children: groupImages
            .map((groupImage) => Cardd(
          groupImage: groupImage,
          isFront: groupImages.last == groupImage,
        ))
            .toList(),
      );
    }
  }



