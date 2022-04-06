import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futr_doc/screens/home/homeScreen.dart';
import 'package:futr_doc/screens/shadowing/shadowingDuration.dart';
import 'package:futr_doc/screens/shadowing/shadowingICD.dart';
import 'package:futr_doc/screens/shadowing/shadowingPatientType.dart';
import 'package:futr_doc/screens/shadowing/shadowingRecap.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhat.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhen.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhere.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shadowing extends StatefulWidget {
  @override
  _ShadowingState createState() => _ShadowingState();
}

class _ShadowingState extends State<Shadowing> {
  final int _numPages = 7;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8.0,
      width: isActive ? 24 : 16,
      decoration: BoxDecoration(
          color: isActive
              ? AppColors.lighterBlue
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

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
    final PageController controller = PageController();
    final node = FocusScope.of(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle.light,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .075),
                    Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05,
                        ),
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.home),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                        )),
                    Container(
                        height: MediaQuery.of(context).size.height * .7,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() => _currentPage = page);
                          },
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingWhere()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingWhen()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingDuration()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingWhat()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingPatientType()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingICD()),
                            Container(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        .125,
                                    right: MediaQuery.of(context).size.width *
                                        .125),
                                child: ShadowingRecap()),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .01),
                      child: Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      )),
                    ),
                    _currentPage != _numPages - 1
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * .075),
                            child: Align(
                                alignment: FractionalOffset.bottomRight,
                                child: FlatButton(
                                    onPressed: () {
                                      _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text('Next',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .025,
                                        ),
                                        Icon(Icons.arrow_forward_ios)
                                      ],
                                    ))),
                          )
                        : Text(''),
                  ]))),
              bottomSheet: _currentPage == _numPages - 1
                  ? Container(
                      height: MediaQuery.of(context).size.height * .125,
                      width: double.infinity,
                      color: AppColors.lighterBlue,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                        child: Center(
                          child: Text(
                            'Submit',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                    )
                  : Text(''),
            )));
  }
}
