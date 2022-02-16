import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
                backgroundColor: const Color(0xFF191256),
                body: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width * .75,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .15),
                            SizedBox(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/futrdoc-logo.png')),
                                height:
                                    MediaQuery.of(context).size.height * .2),
                            Text(
                              'FutrDoc',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'USERNAME',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .025),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .1,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('LOGIN'),
                                style: ElevatedButton.styleFrom(
                                    elevation: 20,
                                    primary: Color(0xFF363B8F),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .1),
                            Text('Dont have an account? ',
                            style: TextStyle(color: Colors.white, fontSize: 20, ),
                            ),
                            TextButton(
                              onPressed: () {}, 
                              child: Text('Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.underline
                              ),
                              ))
                          ],
                        )))))));
  }
}
