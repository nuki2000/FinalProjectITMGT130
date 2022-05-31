import 'package:flutter/material.dart';
import 'dart:async';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  String username = '';

  submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $username!"));
      _scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
      Timer(const Duration(seconds: 0), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 300/pixelRatio, 0.0, 0.0),
                    child: Image.asset(
                      'assets/Gamble.png',
                      height: 800/pixelRatio,
                    ),
                  ),
                  Card(
                    elevation: 0.0,
                    color: Colors.pink[300],
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(35.0))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(79/pixelRatio, 129/pixelRatio, 0.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Create Account (1/8)',
                              style: TextStyle(
                                fontSize: 70.0/pixelRatio,
                                color: Colors.black,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(133/pixelRatio, 115/pixelRatio, 0.0, 0.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'What would you like us to call you?',
                              style: TextStyle(
                                fontSize: 50.0/pixelRatio,
                                color: Colors.black,
                                fontFamily: 'PTSerif',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(133/pixelRatio, 50/pixelRatio, 133/pixelRatio, 0.0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (val) {
                                if (val?.trim().length != null) {
                                  int? value = val?.trim().length;
                                  if(value! < 3) {
                                    return "Username is too short";
                                  }else if (value > 10){
                                    return "Username is too long";
                                  }else {
                                    return null;
                                  }
                                }else {
                                  return null;
                                }
                              },
                              onSaved: (val) => username = val.toString(),
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(
                                  fontSize: 45/pixelRatio,
                                  color: Colors.black54,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: "Must be at least 3 characters",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 97/pixelRatio, 0.0, 0.0),
                          child: Image.asset(
                            'assets/itemillus.png',
                            height: 270/pixelRatio,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(87/pixelRatio, 71/pixelRatio, 87/pixelRatio, 150/pixelRatio),
                          child: GestureDetector(
                            onTap: submit,
                            child: Container(
                              height: 120/pixelRatio,
                              width: 935/pixelRatio,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}