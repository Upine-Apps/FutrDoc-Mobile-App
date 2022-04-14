import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:futr_doc/custom-widgets/customAlert.dart';
import 'package:futr_doc/screens/home/homeScreen.dart';
import 'package:futr_doc/screens/shadowing/shadowingDuration.dart';
import 'package:futr_doc/screens/shadowing/shadowingICD.dart';
import 'package:futr_doc/screens/shadowing/shadowingPatientType.dart';
import 'package:futr_doc/screens/shadowing/shadowingRecap.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhat.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhen.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhere.dart';
import 'package:futr_doc/service/shadowingService.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/customToast.dart';
import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';

class ShadowingScreen extends StatefulWidget {
  @override
  _ShadowingScreenState createState() => _ShadowingScreenState();
}

class _ShadowingScreenState extends State<ShadowingScreen>
    with AutomaticKeepAliveClientMixin {
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

  bool isSpinner = false;
  String theme = '';
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                title: 'Discard Shadowing',
                                description:
                                    'Are you sure you want to return to the home screen?',
                                confirmText: "Discard",
                                onContinue: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                  context
                                      .read<ShadowingProvider>()
                                      .removeLastShadowing();
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * .7,
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() => _currentPage = page);
                            _pageController.keepPage;
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
                        onTap: () async {
                          setState(() {
                            isSpinner = true;
                          });
                          Shadowing lastShadowing =
                              context.read<ShadowingProvider>().lastShadowing;
                          if (fieldValidation(lastShadowing) == true) {
                            var response = await ShadowingService.instance
                                .saveShadowing(lastShadowing, context);
                            if (response['status'] = true) {
                              setState(() {
                                isSpinner = false;
                              });
                              CustomToast.showDialog(
                                  'Added shadowing!', context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            } else {
                              CustomToast.showDialog(
                                  'Failed to add shadowing, try again',
                                  context);
                              setState(() {
                                isSpinner = false;
                              });
                            }
                          } else {
                            setState(() {
                              isSpinner = false;
                            });
                          }
                        },
                        child: Center(
                          child: isSpinner == false
                              ? Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 30,
                                      fontFamily: 'Share'),
                                )
                              : SpinKitWave(
                                  color: Theme.of(context).primaryColor,
                                  size: 20.0,
                                  type: SpinKitWaveType.start),
                        ),
                      ),
                    )
                  : Text(''),
            )));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  fieldValidation(Shadowing lastShadowing) {
    if (lastShadowing.clinic_name!.isEmpty ||
        lastShadowing.clinic_name == null) {
      CustomToast.showDialog('What\'s the clinic\'s name?', context);
      _pageController.jumpToPage(0);
      return false;
    } else if (lastShadowing.date!.isEmpty || lastShadowing.date == null) {
      CustomToast.showDialog('Provide the day you shadowed', context);
      _pageController.jumpToPage(1);
      return false;
    } else if (lastShadowing.duration!.isEmpty ||
        lastShadowing.duration == null) {
      CustomToast.showDialog('How long did you shadow?', context);
      _pageController.jumpToPage(2);
      return false;
    } else if (lastShadowing.activity!.isEmpty ||
        lastShadowing.activity == null) {
      CustomToast.showDialog('Choose an activity that you did', context);
      _pageController.jumpToPage(3);
      return false;
    } else if (lastShadowing.patient_type!.isEmpty ||
        lastShadowing.patient_type == null) {
      CustomToast.showDialog('Choose the patient type', context);
      _pageController.jumpToPage(4);
      return false;
    } else if (lastShadowing.icd10!.isEmpty || lastShadowing.icd10 == null) {
      CustomToast.showDialog('Provide atleast one ICD10', context);
      _pageController.jumpToPage(5);
      return false;
    }
    return true;
  }
}
