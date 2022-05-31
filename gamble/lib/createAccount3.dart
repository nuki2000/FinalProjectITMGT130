import 'package:flutter/material.dart';
import 'dart:async';

class CreateAccount3 extends StatefulWidget {
  const CreateAccount3({Key? key}) : super(key: key);

  @override
  State<CreateAccount3> createState() => _CreateAccount3State();
}

class _CreateAccount3State extends State<CreateAccount3> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  String agepref = '';

  submit() {
    final form = _formKey.currentState;

    if (form!.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $agepref!"));
      _scaffoldMessengerKey.currentState?.showSnackBar(snackbar);
      Timer(const Duration(seconds: 0), () {
        Navigator.pop(context, agepref);
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
                              'Create Account (3/8)',
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
                              'What\'s your age preference?\n(ex: 19 or 19-20)',
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
                                  if(value! < 2) {
                                    return "That is too young!";
                                  }else if (value > 10){
                                    return "Thats too old";
                                  }else {
                                    return null;
                                  }
                                }else {
                                  return null;
                                }
                              },
                              onSaved: (val) => agepref = val.toString(),
                              decoration: InputDecoration(
                                labelText: "Age Preference",
                                labelStyle: TextStyle(
                                  fontSize: 45/pixelRatio,
                                  color: Colors.black54,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: "Enter an Age or a Range",
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