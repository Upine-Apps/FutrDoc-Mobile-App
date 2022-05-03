import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/screens/home/homeScreen.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
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
  Widget build(BuildContext context) => IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'TRACKING',
            body:
                'FutrDoc gives you the best tools to track every clinical shadowing experience',
            image: Center(
                child: CustomImage(
              imagePath: theme == 'Dark'
                  ? 'assets/images/tracking-dark.png'
                  : 'assets/images/tracking-light.png',
            )),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'REPORTING',
            body:
                'Use the FutrDoc dashboard and report feature to showcase your experiences',
            image: Center(
                child: CustomImage(
              imagePath: theme == 'Dark'
                  ? 'assets/images/reporting-dark.png'
                  : 'assets/images/reporting-light.png',
            )),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'RESOURCES',
            body:
                'Help us help you! Give us feedback on how FutrDoc helps you and how we can improve.',
            image: Center(
                child: CustomImage(
              imagePath: theme == 'Dark'
                  ? 'assets/images/resources-dark.png'
                  : 'assets/images/resources-light.png',
            )),
            decoration: getPageDecoration(),
          )
        ],
        next: Icon(Icons.arrow_forward_ios,
            color: Theme.of(context).secondaryHeaderColor),
        showSkipButton: true,
        skip: Text('Skip', style: Theme.of(context).textTheme.bodyText2),
        onSkip: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        dotsDecorator: getDotDecoration(),
        done: Text(
          'Sounds Good',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: Theme.of(context).textTheme.headline2!,
      bodyTextStyle: Theme.of(context).textTheme.bodyText2!,
      imagePadding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * .15),
      bodyPadding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * .025,
          right: MediaQuery.of(context).size.width * .025));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: AppColors.grey,
        size: Size(10, 8),
        activeSize: Size(22, 8),
        activeColor: Theme.of(context).secondaryHeaderColor,
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      );
}
