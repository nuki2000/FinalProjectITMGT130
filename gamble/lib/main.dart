import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:final_project_dating_app/sign_in.dart';
import 'package:final_project_dating_app/home.dart';
import 'package:final_project_dating_app/createAccount.dart';
import 'package:final_project_dating_app/createAccount2.dart';
import 'package:final_project_dating_app/createAccount3.dart';
import 'package:final_project_dating_app/createAccount4.dart';
import 'package:final_project_dating_app/createAccount5.dart';
import 'package:final_project_dating_app/createAccount6.dart';
import 'package:final_project_dating_app/createAccount7.dart';
import 'package:final_project_dating_app/createAccount8.dart';
import 'package:final_project_dating_app/google_sign_in.dart';
import 'package:final_project_dating_app/card_provider.dart';
import 'package:final_project_dating_app/match.dart';
import 'package:final_project_dating_app/chat.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<GoogleSignInProvider>(
        create: (context) => GoogleSignInProvider(),
      ),
      ChangeNotifierProvider<CardProvider>(
        create: (context) => CardProvider(),
      ),
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => const SignUpWidget(),
        '/chat':(context) => const Chat(),
        '/match':(context) => const Match(),
        '/home':(context) => const Home(),
        '/new':(context) => const CreateAccount(),
        '/new2':(context) => const CreateAccount2(),
        '/new3':(context) => const CreateAccount3(),
        '/new4':(context) => const CreateAccount4(),
        '/new5':(context) => const CreateAccount5(),
        '/new6':(context) => const CreateAccount6(),
        '/new7':(context) => const CreateAccount7(),
        '/new8':(context) => const CreateAccount8(),
      },
    ),
  );
}
