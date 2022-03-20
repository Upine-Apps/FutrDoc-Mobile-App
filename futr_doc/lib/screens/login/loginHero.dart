import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHero extends StatefulWidget {
  @override
  _LoginHeroState createState() => _LoginHeroState();
}

class _LoginHeroState extends State<LoginHero> {
  @override
  void initState() {
    super.initState();
    getTheme();
  }
  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('Theme') ?? 'Light';
    });
  }
  String theme = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width *( .75),
        child: SingleChildScrollView(
          child:Column(children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .25
            ),
            CustomImage(
              imagePath: theme == 'Dark' ? 'assets/images/futrdoc-logo.png' : 'assets/images/futrdoc-logo-light.png',
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * .01
            ),
              Text(
                'FutrDoc',
                style: Theme.of(context).textTheme.headline1
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * .05
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              alignment: Alignment.center,
              child: Text(
                'Tracking your shadowing hours\n just got easier',
                style: Theme.of(context).textTheme.bodyText1
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .15
            ),
            CustomElevatedButton(
              onPressed: () {

              },
              text: 'Log In',
              color: AppColors.lighterBlue,
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .05,
              ),
              SizedBox(
              height: MediaQuery.of(context).size.height * .025
            ),
              CustomElevatedButton(
              onPressed: () {

              },
              text: 'Register',
              
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .05,
              )

            
          ],)
        )

      )
    ));
  }
}
