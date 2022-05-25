import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:futr_doc/models/types/UnauthenticatedUserBody.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:futr_doc/theme/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../models/User.dart';
import '../../providers/ShadowingProvider.dart';
import '../../providers/UserProvider.dart';
import '../login/loginHero.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    getSelectPosition();
  }

  getSelectPosition() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPosition = themes.indexOf(prefs.getString('Theme'));
    });
  }

  int selectedPosition = -1;
  List themes = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .075),
              Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Theme.of(context).secondaryHeaderColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Column(
                    children: [
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      Container(
                        child: Card(
                          elevation: 10,
                          color: AppColors.lightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Theme',
                                    style: TextStyle(
                                        color: AppColors.primaryDARK,
                                        fontSize: 16,
                                        fontFamily: 'Share')),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .125,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemBuilder: (context, position) {
                                      return _createList(
                                          context,
                                          themes[position],
                                          position,
                                          themeNotifier);
                                    },
                                    itemCount: themes.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .055),
                      CustomElevatedButton(
                        onPressed: () async {
                          final User user = context.read<UserProvider>().user;
                          var logoutResponse = await UserService.instance
                              .signOutUser(
                                  UnauthenticatedUserBody(
                                      username: user.phone_number),
                                  context);
                          print(logoutResponse['status']);
                          context.read<UserProvider>().clearUser();
                          context.read<ShadowingProvider>().clearShadowings();
                          print(context.read<UserProvider>().user);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginHero()),
                          );
                        },
                        text: 'Sign out',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _createList(context, item, position, themeNotifier) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position, themeNotifier);
      },
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Radio(
            value: selectedPosition,
            groupValue: position,
            activeColor: AppColors.primaryDARK,
            onChanged: (_) {
              _updateState(position, themeNotifier);
            },
          ),
          Text(item,
              style: TextStyle(
                  color: AppColors.primaryDARK,
                  fontSize: 16,
                  fontFamily: 'Share')),
        ],
      ),
    );
  }

  _updateState(int position, ThemeNotifier themeNotifier) {
    setState(() {
      selectedPosition = position;
    });
    onThemeChanged(themes[position], themeNotifier);
  }

  void onThemeChanged(String value, ThemeNotifier themeNotifier) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == 'Dark') {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString('Theme', value);
  }
}
