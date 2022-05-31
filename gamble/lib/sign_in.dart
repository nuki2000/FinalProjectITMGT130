import 'package:final_project_dating_app/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 300/pixelRatio, 0.0, 0.0),
            child: Image.asset(
              'assets/Gamble.png',
              height: 800/pixelRatio,
            ),
          ),
          Divider(
            height: 45.0,
            color: Colors.black,
            thickness: 2.0,
            indent: 96.0/pixelRatio,
            endIndent: 554.0/pixelRatio,
          ),
          const Spacer(),
          Text(
            'Log-in',
            style: TextStyle(
              fontSize: 70.0/pixelRatio,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Inter',
            ),
          ),
          Text(
            'to Gamble',
            style: TextStyle(
              fontSize: 60.0/pixelRatio,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Inter',
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink[400],
              onPrimary: Colors.black,
              minimumSize: Size(824/pixelRatio, 171/pixelRatio),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text(
              'Continue With Google',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.0,
                fontFamily: 'Inter',
              ),
            ),
            onPressed: () async {
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              isAuth = await provider.googleLogin(context);
              isAuth ? Navigator.pushReplacementNamed(context, '/home') : Navigator.pushReplacementNamed(context, '/');
            },
          ),
          const Spacer(),
          const Spacer(),
          const Divider(
            height: 45.0,
            color: Colors.white,
            thickness: 2.0,
            indent: 36.0,
            endIndent: 36.0,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

