import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/custom-widgets/customToast.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';
import 'package:futr_doc/custom-widgets/text-field/customYearField.dart';
import 'package:futr_doc/models/types/UserUpdateBody.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/screens/login/walkthrough.dart';
import 'package:provider/provider.dart';

import '../../models/Shadowing.dart';
import '../../models/User.dart';
import '../../providers/ShadowingProvider.dart';
import '../../providers/UserProvider.dart';
import '../../service/userService.dart';
import '../../theme/appColor.dart';

class ShadowingListScreen extends StatefulWidget {
  @override
  _ShadowingListScreenState createState() => _ShadowingListScreenState();
}

class _ShadowingListScreenState extends State<ShadowingListScreen>
    with AutomaticKeepAliveClientMixin {
  List<Shadowing> shadowings = [];

  @override
  initState() {
    shadowings = context.read<ShadowingProvider>().shadowings;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 110,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).secondaryHeaderColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Your Shadowings',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.start,
            ),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: shadowings.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .1,
                              right: MediaQuery.of(context).size.width * .1),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: Text(
                                          'Clinic Name: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index]
                                              .clinic_name!
                                              .split(',')[0],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: Text(
                                          'Date:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index].date!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: Text(
                                          'Duration:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          '${shadowings[index].duration!} mins',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: Text(
                                          'Activity:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index].activity!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        child: Text(
                                          'Patient Type:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index].patient_type!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .25,
                                          child: Text(
                                            'ICD10s:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index].date!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .015),
                                  Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .25,
                                          child: Text(
                                            'Validated:',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .075),
                                      Expanded(
                                        child: Text(
                                          shadowings[index]
                                              .validated!
                                              .toString()
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
