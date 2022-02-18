import 'package:flutter/material.dart';
import 'package:futr_doc/screens/settings/settings.dart';

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
                            Text('FutrDoc',
                                style: Theme.of(context).textTheme.headline1),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'USERNAME',
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .025),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'PASSWORD',
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
                                    textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .1),
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Sign Up',
                                  style: Theme.of(context).textTheme.button,
                                )),
                            
                          ],
                        )))))));
  }
}
